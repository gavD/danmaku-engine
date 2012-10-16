package uk.co.gavd.danmakuengine.hud {
    import flash.display.*;
    import flash.events.*;
	
    public class Bar extends MovieClip {
        
		public var green:MovieClip;
		public var red:MovieClip;
		
		public function Bar(initialWidth:uint) {
			this.width = initialWidth;
			this.alpha = .5;
		}
    }
}