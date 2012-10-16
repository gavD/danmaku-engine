package uk.co.gavd.danmakuengine.ballistics.firingstrategies 
{
	import uk.co.gavd.danmakuengine.ballistics.BulletFast;
	import uk.co.gavd.danmakuengine.enemies.Enemy;
	import uk.co.gavd.danmakuengine.Game;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Timed extends FiringPattern
	{	
		private var clicksToFire:uint = 0;
		private var rateOfFire:uint;
		
		public function Timed(g:Game, e:Enemy, rateOfFire:uint) 
		{
			super(g, e);
			this.rateOfFire = rateOfFire;
		}
		
		override public function process():void {
			if (--this.clicksToFire <= 0)
			{
				this.clicksToFire = this.rateOfFire;
			}
			else
			{
				return;
			}
			
			this.fire();
		}
	}

}