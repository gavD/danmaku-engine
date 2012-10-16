package uk.co.gavd.danmakuengine.ballistics.firingstrategies 
{
	import uk.co.gavd.danmakuengine.enemies.Enemy;
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Spin extends Timed
	{	
		protected var rotationRate:int;
		protected var rotation:int = 0;
		protected var yoffset:int = 0;
		
		public function Spin(g:Game, e:Enemy, rateOfFire:uint = 5, rotationRate:int = 2, yoffset:int = 0) 
		{
			super(g, e, rateOfFire);
			
			this.rotationRate = rotationRate;
			this.yoffset = yoffset;
		}
		
		override public function process():void {
			super.process();
			
			this.rotation += this.rotationRate;
			if (this.rotation >= 180) {
				this.rotation = -180;
			}
		}
		
		override public function fire():void {
			var b:Bullet = this.enemy.getNextBullet();
			b.y += this.yoffset;
			b.fireAtAngle(rotation + int(Math.random() * 5) + 4);
		}
	}

}