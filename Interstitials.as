package uk.co.gavd.danmakuengine {
	import flash.display.DisplayObject;
    import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Stage;
    import flash.events.Event;
	import flash.events.MouseEvent;
    
    public class Interstitials extends MovieClip {
        
		private var delayFrames:uint;
		
		public var btnUpgradeRof:DisplayObject;
		public var btnUpgradeMissiles:DisplayObject;
		public var btnUpgradeSpreadshot:DisplayObject;
		
		private var game:Game;
		
		private function unpauseGame(e:MouseEvent, self:Interstitials) {
			e.target.visible = false;
			game.unPause();
			game.setScrollingSpeed(Config.SCROLL_SPEED);
			self.visible = false;
		}
		
		public function Interstitials(game:Game) {
			this.game = game;
			var self:Interstitials = this;
			this.alpha = 80;
			
			this.btnUpgradeRof.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) {
				trace("GO upgrade ROF");
				MovieClip(root).reticle.powerupROF();
				unpauseGame(e, self);
			});
			this.btnUpgradeMissiles.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) {
				trace("GO upgrade missiles");
				MovieClip(root).reticle.powerupMissiles();
				unpauseGame(e, self);
			});
			this.btnUpgradeSpreadshot.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent) {
				trace("GO upgrade spreadshot");
				MovieClip(root).game.hero.powerupSpreadShot();
				unpauseGame(e, self);
			});
		}
		
		public function fadeIn(initialDelayFrames:uint):void {
			
			// UNUSED?
			this.addEventListener(Event.ENTER_FRAME, this.updateFrame);
			this.alpha = 0.7;
			this.delayFrames = initialDelayFrames;
		}

		public function updateFrame(evt:Event):void {
			if (this.delayFrames > 0) {
				this.delayFrames--;
				return;
			}
			this.alpha -= 0.05;
			if (this.alpha <= 0) {
				this.removeEventListener(Event.ENTER_FRAME, this.updateFrame);
			}
		}
    }
}