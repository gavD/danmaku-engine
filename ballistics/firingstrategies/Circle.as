package uk.co.gavd.danmakuengine.ballistics.firingstrategies 
{
	import uk.co.gavd.danmakuengine.enemies.Enemy;
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.BulletSlow;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Circle extends Spin
	{	
		protected var density:Number;
		public function Circle(g:Game, e:Enemy, rateOfFire:uint = 5, rotationRate:int = 2, yoffset:int = 0, density:Number = 3) 
		{
			super(g, e, rateOfFire, rotationRate, yoffset);
			this.density = density;
		}
		
		override public function fire():void {
			for (var i:int = -180; i < 180; i = i + density) {
				enemy.getNextBullet(new BulletSlow(game)).fireAtAngle(i + this.rotation);
			}
		}
	}

}