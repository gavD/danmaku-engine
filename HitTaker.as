package uk.co.gavd.danmakuengine {
	import flash.filters.ColorMatrixFilter;
	import fl.motion.AdjustColor;
	import flash.display.MovieClip;
	import flash.media.Sound;
	
	public class HitTaker {
		
		// filter for flash on hit
		private var filterBW:Array;
		private var resetFilterCountdown:uint = 0;
		private var takeHitWav:Sound;
		private var clip:MovieClip;
		
		public function HitTaker(clip:MovieClip) {
			this.clip = clip;
			this.filterBW = loadBWFilter();
			this.takeHitWav = new TakehitWav();
		}
		
		public function onFrame():void {
			if(this.resetFilterCountdown > 0) {
				if(--resetFilterCountdown <= 0) {
					clip.filters = [];
				}
			}
		}
		
		public function takeHit(countDown:uint):void {
			this.takeHitWav.play();
			this.clip.filters = this.filterBW;
			this.resetFilterCountdown = countDown;
		}
		
		public function isFiltered():Boolean {
			return this.resetFilterCountdown > 0;
		}
		
		private function loadBWFilter():Array {
			var color: AdjustColor;
			var colorMatrix: ColorMatrixFilter;
			var matrix: Array;
			 
			color = new AdjustColor();
			color.brightness = 100;
			color.contrast = 20;
			color.hue = 0;
			color.saturation = -100;
			 
			matrix = color.CalculateFinalFlatArray();
			colorMatrix = new ColorMatrixFilter(matrix);
			return [colorMatrix];
		}
	}
}