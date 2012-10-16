package uk.co.gavd.danmakuengine.powerups {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.media.Sound;
	import uk.co.gavd.danmakuengine.Hero;
    
    public class PowerupArmor extends Powerup {
		
		public function PowerupArmor() {
			super();
		}
        
		protected override function upgrade():void {
			MovieClip(root).game.hero.repairArmor();
		}
    }
}
