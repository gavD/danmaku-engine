package uk.co.gavd.danmakuengine.enemies
{
	import uk.co.gavd.danmakuengine.Game;
	import flash.display.*;
	import flash.events.Event;
	import flash.media.Sound;
	import uk.co.gavd.danmakuengine.ballistics.BulletMissile;
	import uk.co.gavd.danmakuengine.ballistics.Bullet;
	
	public class TurretMissile extends Turret
	{
		public function TurretMissile() {
			super();
			
			this.scoreForKill = 120;
			this.hp = 32;
			this.rateOfFire = 200;
			
			this.fireSound = new FourWayWav();
		}
		
		override protected function getNewBullet():Bullet
		{
			return new BulletMissile(game);
		}
	
	}
}