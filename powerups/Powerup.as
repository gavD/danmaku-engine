package uk.co.gavd.danmakuengine.powerups {
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.media.Sound;
	import uk.co.gavd.danmakuengine.Hero;
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.levels.Level;
    
    public class Powerup extends MovieClip {
		
		protected var powerupWav:Sound;
		protected var game:Game;
		
		public function Powerup() {
			this.powerupWav = new PowerupROFWav();
			this.addEventListener ( Event.ENTER_FRAME, this.onFrame, false, 0, true);
		}
		
		public function onFrame(e:Event):void {
			
			var hero:Hero = Level(this.parent.parent).hero;
			if(hero.lAction !== Hero.OK) {
				return;
			}
			
			if (this.hitTestObject(hero.sparkHitZone)) {
				this.powerupWav.play();
				this.removeEventListener(Event.ENTER_FRAME, this.onFrame, false);
                this.upgrade();
				parent.removeChild(this); // TODO seriously, why is it so hard to delete things in AS3?
            	delete this;		      //      I'm not at all convinced this is actually removed...
            }
		}
		
		protected function upgrade():void {
			MovieClip(root).reticle.powerupROF();
		}
    }
}
