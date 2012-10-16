package uk.co.gavd.danmakuengine.enemies {
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	import flash.display.*;
	import flash.events.Event;
	import uk.co.gavd.danmakuengine.ballistics.BulletLong20pxGreen;

    public class Turret4Way extends Turret {
		
		private const BARREL_LENGTH:int = 30;
		
		public function Turret4Way() {
			super();
			
			this.scoreForKill = 20;
			this.hp = 14;
			this.rateOfFire = 50;
			
			this.fireSound = new FourWayWav();
		}
		
		override protected function turnAndFace(targetX:Number):void
		{}
		
		override protected function getNewBullet():Bullet
		{
			return new BulletLong20pxGreen(game);
		}
		
		override protected function doFire (lTargetX:Number, distFromHero:Number):void {
		
            if(--this.clicksToFire <= 0) {
                this.clicksToFire = this.rateOfFire;
            } else {
                return;
            }
			
//			this.fireSound.play();
            
			var bul:Bullet = this.getNextBullet();
			bul.fireAtPoint(this.x, this.y - this.fireRange );
			bul.y += BARREL_LENGTH;
			
			var bul2:Bullet = this.getNextBullet();
			bul2.fireAtPoint(this.x, this.y + this.fireRange );
			bul.y -= BARREL_LENGTH;
			
			var bul3:Bullet = this.getNextBullet();
			bul3.fireAtPoint(this.x + this.fireRange, this.y);
			bul.x += BARREL_LENGTH;
			
			var bul4:Bullet = this.getNextBullet();
			bul4.fireAtPoint(this.x - this.fireRange, this.y );
			bul.x -= BARREL_LENGTH;
            
            return;
        }

    }
}