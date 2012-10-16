package uk.co.gavd.danmakuengine.ballistics {
	import uk.co.gavd.danmakuengine.Game;
	
    public class BulletLong20pxGreen extends Bullet {
    	public function BulletLong20pxGreen(game:Game) {
			super(game);
			
			this.lSpeed = 8;
			this.rotateToFace = true;
		}
    }
}