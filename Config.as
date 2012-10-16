package uk.co.gavd.danmakuengine {
	public class Config {
		// game tweaks
		public static const DEBUG_MODE:Boolean = true;
		public static const ANGLED_SHOTS:Boolean = true;
		public static const SCROLL_SPEED:Number = 1.2; // 1; // 1;
		public static const SCROLL_SPEED_FAST:Number = 20; // 1;
		public static const SCROLL_ACCEL:Number = 0.2; // how fast scrolling can accelerate/decelerate
		public static const MAX_ENEMIES:int = 75;
		
		// Diagnostic mode? Useful for debugging
		public static const DIAGNOSTICS = false;
		
		// game boundaries
		public static const SCROLL_BOUNDS_Y_UPPER:int = 22;
		public static const SCROLL_BOUNDS_Y_LOWER:int = 470;
		
		// display sizes
		public static const HEALTH_BAR_WIDTH:int = 200;
	}
}