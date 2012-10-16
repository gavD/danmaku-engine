package uk.co.gavd.danmakuengine.enemies 
{
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.Config;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Guardian extends Turret
	{
		protected var gameAffected:Boolean = false;
		protected var firePatterns:Array;
		protected var firePatternCount:uint;
		
		public function Guardian() {
			super();
			
			this.firePatterns = new Array();
		}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):void {
			
			if(!gameAffected) {
				game.stopScrolling();
				gameAffected = true;
			}
			
			for (var i:uint = 0; i < firePatternCount; i++) {
				this.firePatterns[i].process();
			}
		}
		
		override protected function turnAndFace(targetX:Number):void
		{}
		
		override protected function getOnScreenMin():uint {
			return 630;
		}
		
		override protected function dieHook():void {
			game.setScrollingSpeed(Config.SCROLL_SPEED_FAST);
		}
	}

}