package uk.co.gavd.danmakuengine.enemies
{
	import flash.display.MovieClip;
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.Config;
	import uk.co.gavd.danmakuengine.levels.layers.Artifacts;
	import uk.co.gavd.diagnostics.ClassUtils;
	import flash.display.DisplayObject;
	
	public class EnemyGenerator
	{
		private var game:Game;
		private var fcEnemies:EnemyCollection;
		
		protected var config:Config;
		
		public function EnemyGenerator(game:Game, fcEnemies:EnemyCollection, config:Config)
		{
			this.game = game;
			this.fcEnemies = fcEnemies;
			this.config = config;
		}
		
		public function detectEnemies(artifacts:Artifacts):void {
			//trace("Detecting enemies,. Current array:" );
			//trace(this.fcEnemies.arEnemies);
			var len:uint = artifacts.numChildren;
			for (var i:uint = 0; i < len; i++) {  
				var display:DisplayObject = artifacts.getChildAt(i);  
				
				if (display is Enemy) {
					//trace("Setting up an enemy " + display);
					Enemy(display).setGame(this.game);
					Enemy(display).stop();
					fcEnemies.registerEnemy(Enemy(display));
				}
			}  
			
			//trace("Detecting enemies COMPLETE. Current array:" );
			//trace(this.fcEnemies.arEnemies);
		}
	}
}