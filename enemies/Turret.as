package uk.co.gavd.danmakuengine.enemies
{
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	import flash.display.*;
	import flash.events.Event;
	import flash.media.Sound;
	
	public class Turret extends Enemy
	{
		
		protected var rateOfFire:int = 120;
		protected var clicksToFire:int = 0;
		
		protected var fireSound:Sound;
		
		public function Turret()
		{
			super();
			
			this.fireRange = 600;
			this.scoreForKill = 4;
			this.hp = 3;
			
			this.fireSound = new TurretWav();
		}
		
		// stub out methods that don't apply to turrets
		override protected function handleMovementY():void
		{
		}
		
		override protected function handleMovementX():void
		{
		}
		
		override protected function doFire(lTargetX:Number, distFromHero:Number):void
		{
			
			if (--this.clicksToFire <= 0)
			{
				this.clicksToFire = this.rateOfFire;
			}
			else
			{
				return;
			}
// TODO			this.fireSound.play();
			
			this.getNextBullet().fireAtTarget(game.hero);
			
			return;
		}
			
		override protected function getNewBullet():Bullet
		{
			return new Bullet(game);
		}
	}
}