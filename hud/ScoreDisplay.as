package uk.co.gavd.danmakuengine.hud {
    import flash.display.*;
    import flash.events.*;
    import flash.text.TextField;
	
    public class ScoreDisplay extends MovieClip {
		
		public var tf:TextField;
		
		private var score:uint = 0;
        
		public function ScoreDisplay() {

		}
		
		public function scoreUp(up:uint):void {
			score += up;
			tf.text = score.toString(10);
		}
    }
}