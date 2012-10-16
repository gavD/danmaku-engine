package uk.co.gavd.danmakuengine.ballistics {
	import uk.co.gavd.danmakuengine.Game;
	
    public class BulletSlow extends Bullet {
    	public function BulletSlow(game:Game) {
			super(game);
			
			this.lSpeed = 2;
		}
    }
}