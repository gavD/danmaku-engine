package uk.co.gavd.danmakuengine.ballistics.firingstrategies 
{
	import uk.co.gavd.danmakuengine.enemies.Enemy;
	import uk.co.gavd.danmakuengine.Game;
	
	/**
	 * ...
	 * @author Gavin Davies
	 */
	public class FiringPattern 
	{
		protected var enemy:Enemy;
		protected var game:Game;
		public function FiringPattern(g:Game, e:Enemy) 
		{
			this.game = g;
			this.enemy = e;
		}
		
		public function process():void {
			throw new Error("Must override process()");
		}
		
		public function fire():void {
			throw new Error("Must override fire()");
		}
		
	}

}