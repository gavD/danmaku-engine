package uk.co.gavd.danmakuengine.enemies
{
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.Config;
	import uk.co.gavd.danmakuengine.ballistics.*;
	import flash.display.*;
	import flash.events.Event;
	import flash.media.Sound;
	
	public class Guardian2 extends Turret
	{
		
		private var gameAffected:Boolean = false;
		private var bulrot:int = 0;
		private var rotrate:int = 1;
		
		public function Guardian2()
		{
			super();
			
			this.fireRange = 800;
			this.scoreForKill = 400;
			this.rateOfFire = 9;
			this.hp = 300;
			
			this.fireSound = new BulletGuardian1Wav();
		}
		
		override protected function turnAndFace(targetX:Number):void
		{}
		
		override public function takeHit(damage:uint):void
		{
			super.takeHit(damage);
			if (this.hp < 50)
			{
				rotrate = 6;
				this.rateOfFire = 8;
			}
			else if (this.hp < 100)
			{
				rotrate = 5;
			}
			else if (this.hp < 150)
			{
				rotrate = 4;
			}
			else if (this.hp < 270)
			{
				rotrate = 2;
			}
			else
			{
				this.x--;
			}
		}
		
		override protected function getOnScreenMin():uint
		{
			return 670;
		}
		
		override protected function getNewBullet():Bullet
		{
			return new BulletWhite(game);
		}
		
		override protected function doFire(lTargetX:Number, distFromHero:Number):void
		{
			if (!gameAffected)
			{
				game.stopScrolling();
				gameAffected = true;
			}
			
			if (--this.clicksToFire <= 0)
			{
				this.clicksToFire = this.rateOfFire;
			}
			else
			{
				return;
			}
			
			if (bulrot > 46)
			{
				rotrate *= -1;
			}
			else if (bulrot < 0)
			{
				rotrate *= -1;
			}
			bulrot += rotrate;
			
			this.getNextBullet().fireAtAngle(0 + bulrot);
			this.getNextBullet().fireAtAngle(20 + bulrot);
			this.getNextBullet().fireAtAngle(40 + bulrot);
			this.getNextBullet().fireAtAngle(60 + bulrot);
			this.getNextBullet().fireAtAngle(80 + bulrot);
			this.getNextBullet().fireAtAngle(100 + bulrot);
			this.getNextBullet().fireAtAngle(120 + bulrot);
			this.getNextBullet().fireAtAngle(140 + bulrot);
			this.getNextBullet().fireAtAngle(160 + bulrot);
			this.getNextBullet().fireAtAngle(180 + bulrot);
			
			this.getNextBullet().fireAtAngle(-20 + bulrot);
			this.getNextBullet().fireAtAngle(-40 + bulrot);
			this.getNextBullet().fireAtAngle(-60 + bulrot);
			this.getNextBullet().fireAtAngle(-80 + bulrot);
			this.getNextBullet().fireAtAngle(-100 + bulrot);
			this.getNextBullet().fireAtAngle(-120 + bulrot);
			this.getNextBullet().fireAtAngle(-140 + bulrot);
			this.getNextBullet().fireAtAngle(-160 + bulrot);
		}
	}
}