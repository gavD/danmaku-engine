package uk.co.gavd.danmakuengine.enemies
{
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.Config;
	import uk.co.gavd.danmakuengine.ballistics.*;
	import flash.display.*;
	import flash.events.Event;
	import flash.media.Sound;
	
	public class Guardian1 extends Enemy
	{
		
		public static const MOVEMENT_SPEED:int = 1;
		
		private var yMovementPerFrame:int = MOVEMENT_SPEED;
		protected var fireSound:Sound;
		
		private var firePattern:Array = [false, false, false, false, false, false, false, false, false, false, false, false, true, false, true, false, true, false, true, false, true, false, false, true, false, false, true, false, false, true];
		private var firePointer:int = 0;
		
		private var targetX:Number = 0;
		private var targetY:Number = 0;
		private var gameAffected:Boolean = false;
		
		public function Guardian1()
		{
			super();
			
			this.fireRange = 800;
			this.scoreForKill = 400;
			this.hp = 150;
			
			this.fireSound = new BulletGuardian1Wav();
			this.hitArea.visible = false;
		}
		
		override public function checkHit(bullet:Bullet):Boolean
		{
			return bullet.hitArea.hitTestObject(this.hitArea);
		}
		
		// stub out methods that don't apply to turrets
		override protected function handleMovementY():void
		{
			this.y += this.yMovementPerFrame;
			if (this.y > 350)
			{ // TODO magic number
				this.yMovementPerFrame = -1 * MOVEMENT_SPEED;
			}
			else if (this.y < 140)
			{ // TODO magic number
				this.yMovementPerFrame = MOVEMENT_SPEED;
			}
		}
		
		override protected function getOnScreenMin():uint
		{
			return 600;
		}
		
		override protected function handleMovementX():void
		{
		}
		
		override protected function getNewBullet():Bullet
		{
			return new BulletFast(game);
		}
				
		override protected function doFire(lTargetX:Number, distFromHero:Number):void
		{
			if (!gameAffected)
			{
				game.stopScrolling();
				gameAffected = true;
			}
			
			if (++this.firePointer > this.firePattern.length)
			{
				this.firePointer = 0;
				
				// only re-targetsa when loop round the array
				targetX = game.hero.x - game.artifacts.x;
				targetY = game.hero.y;
//				this.fireSound.play();
			}
			if (!this.firePattern[this.firePointer])
			{
				return;
			}
			
			var bul:Bullet = this.getNextBullet()
			bul.fireAtPoint(targetX, targetY);
			bul.y += 70;
			
			var bul2:Bullet = this.getNextBullet()
			bul2.fireAtPoint(targetX, targetY);
			bul2.y -= 65;
			
			var bul3:Bullet = this.getNextBullet()
			bul3.fireAtPoint(targetX, targetY);
			
			var bul4:Bullet = this.getNextBullet()
			bul4.fireAtPoint(targetX, targetY);
			bul4.y += 125;
			
			var bul5:Bullet = this.getNextBullet()
			bul5.fireAtPoint(targetX, targetY);
			bul5.y -= 95;
		}
	}
}