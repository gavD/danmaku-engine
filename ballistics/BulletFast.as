package uk.co.gavd.danmakuengine.ballistics {
	import uk.co.gavd.danmakuengine.Game;
	
    public class BulletFast extends Bullet {
    	public function BulletFast(game:Game) {
			super(game);
			
			this.lSpeed = 4;
		}
    }
}