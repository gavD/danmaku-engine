package uk.co.gavd.danmakuengine.hud {
    import flash.display.*;
    import flash.events.*;
    import flash.text.TextField;
	
    public class ScoreFloater extends MovieClip {
		
		public var scoreUpField:TextField;
		
		public function ScoreFloater(score:uint) {
			this.scoreUpField.text = score.toString(10);
			this.alpha = 1;
			this.addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
		}
		
		private function onFrame(e:Event):void {
			this.y--;
			this.alpha -= .1;
			if(this.alpha <= 0) {
				this.blam();
			}
		}
		
		public function blam():void {
			this.removeEventListener(Event.ENTER_FRAME, this.onFrame);
			this.parent.removeChild(this);
			//this.dispose();
		}
	}
}