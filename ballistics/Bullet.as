package uk.co.gavd.danmakuengine.ballistics {
    import flash.display.MovieClip;
    import flash.events.Event;
	import flash.text.engine.BreakOpportunity;
    import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.Hero;
    
    public class Bullet extends MovieClip {
		
        // dynamically calculated stuff
        public var triggered:Boolean = false;
        protected var framesToLive:int = 1000;
        protected var xTravel:Number = 0;
        protected var yTravel:Number = 0;
        
        // info about this bullet
        public var damage:Number = 1;
        protected var travel:Number = 800; // how many px this bullet can fly
		
		protected var lSpeed:Number = 2;
		
		protected var game:Game;
		protected var rotateToFace:Boolean = false;
		
		protected static const ONEEIGHTY_OVER_PI:Number = (180/Math.PI);
		
		public function Bullet(game:Game) {
			this.stop();
			this.game = game;
			this.hitArea.visible = false;
			this.addEventListener(Event.ENTER_FRAME, this.onFrame, false, 0, true);
		}
        
		public function fireAtTarget(target:MovieClip):void {
            this.fireAtPoint(target.x - game.artifacts.x, target.y);
		}
		      
        public function fireAtPoint(targetX:Number, targetY:Number):void {
            var radians:Number = this.getAngleTo(targetX, targetY);			
			this.fireAtAngleRadians(radians);
        }
                
		public function fireAtAngle(degrees:Number):void {
            var radians:Number = degrees * Math.PI / 180;
			this.fireAtAngleRadians(radians);
		}
		
		public function fireAtAngleRadians(radians:Number):void {

			this.xTravel = lSpeed * Math.cos(radians);
			this.yTravel = lSpeed * Math.sin(radians);
			
 			var opp:Number = Math.sin(radians) * travel; // opp = h * s
			this.calculateFramesToLive(this.y + opp);

			if(this.rotateToFace) {
				this.rotation = (radians * (ONEEIGHTY_OVER_PI));
			}
        }
        
        protected function getAngleTo(aimAtX:Number, aimAtY:Number):Number {
            return Math.atan2(aimAtY - this.y, aimAtX - this.x);
        }
        
        private function calculateFramesToLive(targetY:Number):void {
            // work out how long this bullet has to live
            var defaultFramesToLive:uint = this.travel / this.lSpeed;
			
			var ticksToOutOfY:uint = defaultFramesToLive;
    
            if (targetY < y) {
				ticksToOutOfY = (y + 50) / Math.abs(yTravel);
            } else if (targetY > y) {
				ticksToOutOfY = ((this.stage.stageHeight + 50) - y) / yTravel;
            }
            this.framesToLive = (ticksToOutOfY !== 0 && (ticksToOutOfY < defaultFramesToLive)) ? ticksToOutOfY : defaultFramesToLive;
        }
        
        protected function moveTowardsTarget():void {
            
            this.x += this.xTravel;
            this.y += this.yTravel;
    
            if (--this.framesToLive <= 0) {
                
                if(!this.triggered) {
                    this.triggered = true;
                    this.gotoAndPlay("explode");
                }
                this.xTravel /= 2; // slow the bullet
                this.yTravel /= 2; // slow the bullet
            }
        }
        
        public function onFrame(e:Event):void {
            this.moveTowardsTarget();
            if(this.triggered) {
                return;
            }
            this.checkForHits();
        }
        
        protected function checkForHits():void {

			if( game.hero.lAction != Hero.OK ) {
				return;
			}

			if (this.hitArea.hitTestObject(game.hero.hitArea)) {
				this.triggered = true;
                game.hero.takeHit(this.damage);
                this.gotoAndPlay("explode");
            } else {
				if(this.hitArea.hitTestObject(game.hero.sparkHitZone)) {
					MovieClip(root).comboBar.ticksUp();
					MovieClip(root).scoreDisplay.scoreUp(1); // TODO magic number
					game.hero.sparks.visible = true;
					// TODO hero sparks
				}
			}
        }
		
		public function blam():void {
			this.removeEventListener(Event.ENTER_FRAME, this.onFrame);
			this.parent.removeChild(this);
			this.dispose();
		}
		
		public function dispose() {
			this.stop();
		}
    }
}