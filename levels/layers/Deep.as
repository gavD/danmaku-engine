package uk.co.gavd.danmakuengine.levels.layers 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class Deep extends Sprite
	{
		public var tileWidth:uint = 1;
		protected var graphicsPath:String = "";
		
		public function Deep() 
		{
		}
		
		protected function loadGraphics() {
			
			for (var i = 0; i < 2; i++) {
				var loader:Loader = new Loader();
				var url:URLRequest = new URLRequest(this.graphicsPath);
				this.addChild(loader);
				loader.load(url);
				loader.x = i * this.tileWidth;
			}
		}
	}
}