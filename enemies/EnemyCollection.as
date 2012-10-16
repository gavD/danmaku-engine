package uk.co.gavd.danmakuengine.enemies {
	import flash.display.MovieClip;
    import flash.events.Event;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
    import uk.co.gavd.danmakuengine.Config;
    import flash.media.Sound;
    import uk.co.gavd.danmakuengine.ballistics.BulletHero;
    
    public class EnemyCollection {
		
		public var arEnemies:Array; // TODO private
		
		private var theRoot:MovieClip;
		
		private var config:Config;
		
		private var explodeWav:Sound;		
		
		public function EnemyCollection(theRoot:MovieClip, config:Config) {
			this.arEnemies = new Array();
			this.theRoot = theRoot;
			this.config = config;
			this.explodeWav = new ExplodeWav();
		}
		
		public function killAll(now:Boolean = false ):void {
			for (var i:Number = 0; i < this.arEnemies.length; i++) {
				if (this.arEnemies[i] === null) {
					continue;
				}
				if (now) {
					killNow(this.arEnemies[i]);
				} else {
					kill(this.arEnemies[i]);
				}
				this.arEnemies[i] = null
			}
			this.arEnemies = new Array();
		}
		
		public function registerEnemy(enemy:Enemy):void {
//			trace("Register " + enemy);
			// let's see if we can put it in an existing place
			var spaceFound:Boolean = false;
			for(var i:Number = 0; i < this.arEnemies.length; i++) {
				if (this.arEnemies[i].x == undefined) {
					trace("Put in at " + i);
					this.arEnemies[i] = enemy;
					spaceFound = true;
					break;
				}
			}
	
			// chuck it on the end of the array
			if (!spaceFound) {
				if (this.arEnemies.length >= theRoot.MAX_ENEMIES) {
					trace("ALREADY HAVE " + theRoot.MAX_ENEMIES + " enemies, BLAMMING");
					//theRoot.absDelete(enemy);
				} else {
					this.arEnemies.push(enemy);
				}
			}
		}
		
		public function detectHits(bullet:Bullet):void {
			for (var i:Number = 0; i < this.arEnemies.length; i++) {
				
				if (this.arEnemies[i] == null) { 
					continue;
				}
				
				var enemy:Enemy = this.arEnemies[i];
				
				if (enemy.lAction == Enemy.DYING) {
					continue;
				}
				
				if(enemy.checkHit(bullet)) {
					bullet.triggered = true;
					bullet.gotoAndPlay("explode");
					enemy.takeHit(bullet.damage);
					return; // no point in staying in the loop if we hit something!
				}
			}
		}
		
		public function kill(enemy:MovieClip):void {
			//trace("Kill " + enemy);
			this.explodeWav.play();

			enemy.lAction = Enemy.DYING;

			enemy.gotoAndPlay("die");
		}
		
		public function killNow(enemy:Enemy) {
			//trace("Remove " + enemy + " from " + enemy.parent);
			enemy.parent.removeChild(enemy);
			//trace("REMOVED");
			enemy = null;
		}
		
		public function onFrame(e:Event):void {
			//trace("onFrame" + this.arEnemies.length);
		
			for (var i:Number = 0; i < this.arEnemies.length; i++) {
				if(this.arEnemies[i] == null) {
					// TODO shrink array?
					continue;
				}
				
				var enemy:Enemy = this.arEnemies[i];
				
				if (enemy.lAction == Enemy.DEAD) {
					//trace(enemy + " is dead, clear it");
					killNow(enemy);
					this.arEnemies[i] = null;
					continue;
				}
				
				enemy.process();
			}
		}
    }
}