package uk.co.gavd.danmakuengine.enemies {
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	import uk.co.gavd.danmakuengine.ballistics.BulletSlow;
	import flash.events.Event;

    public class TurretScatter extends Turret  {
    
		public function TurretScatter() {
			super();
			
			this.fireRange = 600;
			this.rateOfFire = 110;
			this.scoreForKill = 10;
			this.hp = 3;
			
			this.fireSound = new ShotgunWav();
		}
    
		override protected function doFire (lTargetX:Number, distFromHero:Number):void {
			if(--this.clicksToFire <= 0) {
				this.clicksToFire = this.rateOfFire;
			} else {
				return;
			}
			
//			this.fireSound.play();
			
			if(this.facingLeft) {
				this.getNextBullet().fireAtAngleRadians(3.4);
				this.getNextBullet().fireAtAngleRadians(3.6);
				this.getNextBullet().fireAtAngleRadians(3.8);
				this.getNextBullet().fireAtAngleRadians(4);
			} else {
				this.getNextBullet().fireAtAngleRadians(5.2);
				this.getNextBullet().fireAtAngleRadians(5.4);
				this.getNextBullet().fireAtAngleRadians(5.6);
				this.getNextBullet().fireAtAngleRadians(5.8);
			}
		}
    }
}