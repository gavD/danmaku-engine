package uk.co.gavd.danmakuengine.ballistics {
	import uk.co.gavd.danmakuengine.Game;
	
    public class BulletLong20pxPink extends Bullet {
    	public function BulletLong20pxPink(game:Game) {
			super(game);
			
			this.lSpeed = 3;
			this.rotateToFace = true;
		}
    }
}