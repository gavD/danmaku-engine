package uk.co.gavd.danmakuengine.hud {
    import flash.events.*;
    import uk.co.gavd.danmakuengine.Hero;
    import flash.text.TextField;
	
    public class ComboBar extends Bar {
		
		private const MAX_TICKS:uint = 140;
		private var ticks:uint = MAX_TICKS;
		public var combo:uint = 0;
		public var tf:TextField;

		public function ComboBar(initialWidth:uint) {
			super(initialWidth);
			this.addEventListener ( Event.ENTER_FRAME, this.onFrame, false, 0, true);
		}
		
		public function comboUp():void {
			this.combo++;
			this.ticks = this.MAX_TICKS;
		}
		
		public function ticksUp():void {
			this.ticks+=2;
			if(this.ticks > this.MAX_TICKS) {
				this.ticks = this.MAX_TICKS;
			}
		}
		
		protected function onFrame(e:Event):void {
			if(this.ticks > 0) {
				this.green.width = this.width * (this.ticks / this.MAX_TICKS);
				--this.ticks;
			} else {
				this.combo = 0;
			}
			this.updateCombo();
		}
		
		protected function updateCombo():void {
			tf.text = this.combo.toString(10);
		}
		
		public function getCombo():uint {
			return this.combo;
		}
    }
}