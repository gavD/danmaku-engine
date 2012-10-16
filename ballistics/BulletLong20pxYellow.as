package uk.co.gavd.danmakuengine.ballistics {
	import uk.co.gavd.danmakuengine.Game;
	
    public class BulletLong20pxYellow extends Bullet {
    	public function BulletLong20pxYellow(game:Game) {
			super(game);
			
			this.lSpeed = 5;
			this.rotateToFace = true;
		}
    }
}