package uk.co.gavd.danmakuengine.powerups {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.media.Sound;
	import uk.co.gavd.danmakuengine.Hero;
    
    public class PowerupSpreadShot extends Powerup {
		
		public function PowerupSpreadShot() {
			super();
		}
		
		protected override function upgrade():void {
			MovieClip(root).game.hero.powerupSpreadShot();
		}
    }
}
