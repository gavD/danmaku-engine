package uk.co.gavd.danmakuengine {
    import flash.display.*;
    import flash.events.*;
	import uk.co.gavd.danmakuengine.ballistics.*;
	import flash.media.Sound;
	import uk.co.gavd.danmakuengine.enemies.Enemy;
	import flash.ui.Keyboard;
    
    public class Reticle extends MovieClip {
        
        private var isMouseDown:Boolean = false;
        private var framesBetweenShots:uint = 10;
        private var clicksToNextShot:uint = 0;
		private var missileRof:uint = 50;
		private var clicksToNextMissile:int = 0;
        
		private var game:Game;
		private var config:Config;
		
		private const MIN_FRAMES_BETWEEN_SHOTS:uint = 3;
		
		private var cannonWav:Sound;

		public function Reticle(game:Game, config:Config) {
			this.game = game;
			this.config = config;
			this.cannonWav = new CannonWav;
		}
		
		
		public function powerupROF():void {
			this.framesBetweenShots -= 2;
			if(this.framesBetweenShots < MIN_FRAMES_BETWEEN_SHOTS) {
				this.framesBetweenShots = MIN_FRAMES_BETWEEN_SHOTS;
			}
		}
        
		private var missiles:Boolean = false;
		public function powerupMissiles():void {
			this.missiles = true;
		}
        
		private function fireMissileAtNearestFrontEnemy():void {
			
			var len:uint = game.artifacts.numChildren;
			var closest:Number = 99999;
			var nearestEnemy:Enemy = null;
			for (var i:uint = 0; i < len; i++) {  
				var display:DisplayObject = game.artifacts.getChildAt(i);  
				
				if (display is Enemy) {
					var heroX:Number = game.hero.x - game.artifacts.x;
					var heroY:Number = game.hero.y;
					
					var distX = display.x - heroX;
					var distY = display.y - heroY;
					var dist = Math.sqrt((distX * distX) + (distY * distY));
					
					if (distX > 0 && dist < closest) {
						closest = dist;
						nearestEnemy = Enemy(display);
					}
				}
			} 
			
			if (nearestEnemy !== null && closest < 1000 ) { // TODO correct width for missiles?
				//trace("Nearest enemy is " + nearestEnemy + " which is " + closest + " px away");
				var b:BulletHeroMissile = this.getNextMissile();
				b.fireAtTarget(nearestEnemy);
				if (nearestEnemy.y < game.hero.y) {
					b.rotation = -90;	
				} else {
					b.rotation = 90;
				}
			} // else there is no valid missile target
		}
		
		private function fireBullet(directional):void {
            
            // fire a bullet
            var b:BulletHero = this.getNextBullet();
			
            if(directional) {
                var virtualCursorX:int = this.x - game.x - game.artifacts.x;
				var radians:Number = Math.atan2(this.y - b.y, virtualCursorX - b.x);
				b.fireAtAngleRadians(radians);
            } else { // straight line fire
                b.fireAtPoint(b.x + 750, b.y);
            }
			
			cannonWav.play();
			
			if(game.hero.spreadShot > 0) {
				this.getNextBullet().fireAtAngle( -5);
				this.getNextBullet().fireAtAngle(5);
				if (game.hero.spreadShot > 1) {
					this.getNextBullet().fireAtAngle(-12);
					this.getNextBullet().fireAtAngle(12);
					if(game.hero.spreadShot > 2) {
						this.getNextBullet().fireAtAngle(-25);
						this.getNextBullet().fireAtAngle(25);
						if(game.hero.spreadShot > 3) {
							this.getNextBullet().fireAtAngle(-35);
							this.getNextBullet().fireAtAngle(35);
						}
					}
				}
			}
        }
		
		private function getNextBullet():BulletHero {
			var b:BulletHero = new BulletHero(game);
			this.initBullet(b);
			return b;
		}
		
		private function getNextMissile():BulletHeroMissile {
			var b:BulletHeroMissile = new BulletHeroMissile(game);
			this.initBullet(b);
			return b;
		}
		
		private function initBullet(b:Bullet):void {
            b.x = game.hero.x - game.artifacts.x + 55;
            b.y = game.hero.y + 14;
			game.artifacts.addChild(b); 
		}
        
        public function doMouseDown(event:MouseEvent):void {
            this.isMouseDown = true;
        }
        public function doMouseUp(event:MouseEvent):void {
            this.clicksToNextShot = 0;
            this.isMouseDown = false;
        }
        
        public function onFrame(e:Event):void {
			if (game.isPaused()
			 || game.hero.lAction != Hero.OK
			) {
				return;
			}
			
			this.x = game.parent.mouseX;
            this.y = game.parent.mouseY;
    
            var lXDir:Number = 0;
            var lYDir:Number = 0;
			
            if (this.isKeyPressed(Keyboard.D) || this.isKeyPressed(Keyboard.RIGHT)) { // d
                lXDir = 1;
            } else if (this.isKeyPressed(Keyboard.A) || this.isKeyPressed(Keyboard.LEFT)) { // a
                lXDir = -1;
            }
            if (this.isKeyPressed(Keyboard.W) || this.isKeyPressed(Keyboard.UP)) { // w
                lYDir = -1;
            } else if (this.isKeyPressed(Keyboard.S) || this.isKeyPressed(Keyboard.DOWN)) { //s
                lYDir = 1;
            }
			if(!game.hero.isFiring) {
				lXDir *= 2;
				lYDir *= 2;
			}
            game.hero.applyMovement(lXDir,lYDir);
			
			game.hero.isFiring = this.isMouseDown || isKeyPressed(Keyboard.SPACE);
			
			if(this.missiles && this.clicksToNextMissile > 0) {
				--this.clicksToNextMissile;
			}
            if (this.isMouseDown || isKeyPressed(Keyboard.SPACE)) {
				
                if(--this.clicksToNextShot <= 0) {
                    this.fireBullet(false);
                    this.clicksToNextShot = this.framesBetweenShots;
                }
				
				if(this.missiles && this.clicksToNextMissile <= 0) {
					this.fireMissileAtNearestFrontEnemy();
					this.clicksToNextMissile = this.missileRof;
				}
            }
        }
		
		
		private var _keys:Array = new Array();
		public function handleKeyDown(evt:KeyboardEvent):void {
			if (_keys.indexOf(evt.keyCode) == -1) {
				_keys.push(evt.keyCode);
			}
		}

		public function handleKeyUp(evt:KeyboardEvent):void {
			var i:int = _keys.indexOf(evt.keyCode);

			if (i > -1) {
				_keys.splice(i, 1);
			}
		}

		public function isKeyPressed(key:int):Boolean {
			return _keys.indexOf(key) > -1;
		}
    }
	
	
}