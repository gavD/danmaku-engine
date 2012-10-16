package uk.co.gavd.danmakuengine.powerups {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.media.Sound;
	import uk.co.gavd.danmakuengine.Hero;
    
    public class PowerupROF extends Powerup {
		
		public function PowerupROF() {
			super();
		}
		
		protected override function upgrade():void {
			MovieClip(root).reticle.powerupROF();
		}
    }
}
