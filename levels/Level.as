package uk.co.gavd.danmakuengine.levels 
{
	import flash.display.DisplayObject;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	import uk.co.gavd.danmakuengine.Config;
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.Hero;
	import uk.co.gavd.danmakuengine.levels.layers.Deep;
	import uk.co.gavd.danmakuengine.levels.layers.Mid;
	import uk.co.gavd.danmakuengine.levels.layers.Artifacts;
	import flash.display.MovieClip;
	import uk.co.gavd.danmakuengine.powerups.Powerup;
	import uk.co.gavd.diagnostics.TimelineUtils;
	import flash.events.*;
	  
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Level extends MovieClip
	{
		public var deep:Deep;
		public var mid:Mid;
		public var artifacts:Artifacts;
		public var hero:Hero;
		
		private var scrollSpeed = 30;
		private var targetScrollSpeed = Config.SCROLL_SPEED;
		
		public function Level() {
		}
		
		public function setScrollSpeed(newSpeed:uint) {
			trace("LEVEL : set speed to " + newSpeed);
			this.targetScrollSpeed = newSpeed;
		}
		
		public function setHero(h:Hero):void {
			this.hero = h;
			this.addChild(this.hero);
			this.addChild(this.artifacts);
			this.hero.y = 200;
			this.hero.x = 40;
		}
		
		public function clearAll():void {
			var toRemove:Array = new Array;
			
			trace("Before remove bullets: " + TimelineUtils.countTree(this));
			var i:uint;
			for (i = 0; i < this.artifacts.numChildren; i++ ) {
				//trace("Child at " + i + " is " + );
				
				var tmp:DisplayObject = this.artifacts.getChildAt(i);
				if(tmp is Bullet) {
					toRemove.push(tmp);
				} else if (tmp is Powerup) {
					toRemove.push(tmp);
				}
			}
			
			for (i = 0; i < toRemove.length; i++ ) {
				var tmp2:MovieClip = toRemove[i];
				if(tmp2 is Bullet) {
					Bullet(tmp2).removeEventListener(Event.ENTER_FRAME, Bullet(tmp2).onFrame);
					this.artifacts.removeChild(tmp2);
				} else if (tmp2 is Powerup) {
					Powerup(tmp2).removeEventListener(Event.ENTER_FRAME, Powerup(tmp2).onFrame);
					this.artifacts.removeChild(tmp2);
				}
			}
		}
		
		public function scroll():void {
			if (this.scrollSpeed > this.targetScrollSpeed) {
				this.scrollSpeed -= Config.SCROLL_ACCEL;
			} else if (this.scrollSpeed < this.targetScrollSpeed)  {
				this.scrollSpeed += Config.SCROLL_ACCEL;
			}
			
			if (this.scrollSpeed < Config.SCROLL_ACCEL) {
				this.scrollSpeed = 0;
			}
			
			this.artifacts.x -= this.scrollSpeed;
			this.mid.x = this.artifacts.x;
			this.deep.x -= this.scrollSpeed * 0.2;
			if (this.deep.x < (this.deep.tileWidth * -1)) {
				this.deep.x += this.deep.tileWidth;
			}
		}
		
		public function isComplete():Boolean {
			return this.mid.x <
				((-1 * (this.mid.width)) - 800)
			;
		}
		
	}

}