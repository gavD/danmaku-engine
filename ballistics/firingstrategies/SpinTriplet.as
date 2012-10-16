package uk.co.gavd.danmakuengine.ballistics.firingstrategies 
{
	import uk.co.gavd.danmakuengine.enemies.Enemy;
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	import uk.co.gavd.danmakuengine.ballistics.BulletLong20pxYellow;
	import uk.co.gavd.danmakuengine.ballistics.BulletLong20pxGreen;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class SpinTriplet extends Spin
	{	
		public function SpinTriplet(g:Game, e:Enemy, rateOfFire:uint = 5, rotationRate:int = 2, yoffset:int = 0) 
		{
			super(g, e, rateOfFire, rotationRate, yoffset);
		}
		
		override public function fire():void {
			super.fire();

			var b:Bullet = enemy.getNextBullet(new BulletLong20pxYellow(this.game));		
			b.y += this.yoffset;
			b.fireAtAngle(rotation + int(Math.random()*10) - 5);

			var b2:Bullet = enemy.getNextBullet(new BulletLong20pxGreen(this.game));
			b2.y += this.yoffset;
			b2.fireAtAngle(rotation);
		}
	}

}