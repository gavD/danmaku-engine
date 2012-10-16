package uk.co.gavd.danmakuengine.ballistics {
	import flash.display.MovieClip;
	import uk.co.gavd.danmakuengine.Game;
	
    public class BulletHeroMissile extends BulletMissile {
		public function BulletHeroMissile(game:Game) {
			super(game);
			
			this.damage = 30;
			this.turn = 3.3;
			this.lSpeed = 8;
		}
		
		override protected function checkForHits():void {
			var theRootx:MovieClip = MovieClip(root); // TODO DI this?
			theRootx.fcEnemies.detectHits(this);
        }
    }
}