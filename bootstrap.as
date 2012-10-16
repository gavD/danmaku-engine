import flash.system.System;
import flash.display.MovieClip;
import flash.display.DisplayObject;
import uk.co.gavd.battleplatforms.levels.level1.Level1;
import uk.co.gavd.battleplatforms.levels.level2.Level2;
import uk.co.gavd.battleplatforms.levels.level3.Level3;
import uk.co.gavd.battleplatforms.levels.level4.Level4;
import uk.co.gavd.danmakuengine.*;
import uk.co.gavd.danmakuengine.hud.*;
import uk.co.gavd.danmakuengine.enemies.*;
import uk.co.gavd.danmakuengine.levels.LevelCollection;
import uk.co.gavd.diagnostics.*;

stage.quality = StageQuality.LOW;
var theRoot:MovieClip = MovieClip(root); // TODO perhaps factor this out entirely

var levels:LevelCollection = new LevelCollection();

levels.addLevel(Level1);
levels.addLevel(Level2);
levels.addLevel(Level3);
levels.addLevel(Level4);

var game:Game = new Game(levels);
this.addChild(game);

var conf:Config = new Config();
game.setConfig(conf);
var fcEnemies:EnemyCollection = new EnemyCollection(theRoot, conf);
var enemyGenerator:EnemyGenerator = new EnemyGenerator(game, fcEnemies, conf);
game.setEnemyGenerator(enemyGenerator);
game.setEnemyCollection(fcEnemies);

game.loadLevel();

var reticle:Reticle = new Reticle(game, conf);
stage.addEventListener(KeyboardEvent.KEY_DOWN, reticle.handleKeyDown);
stage.addEventListener(KeyboardEvent.KEY_UP, reticle.handleKeyUp);

stage.addChild(reticle);

var comboBar:ComboBar = new ComboBar(Config.HEALTH_BAR_WIDTH);
comboBar.x = 550;
comboBar.y = 10;
this.addChild(comboBar);

var healthBar:HealthBar = new HealthBar(game.hero, Config.HEALTH_BAR_WIDTH);
healthBar.x = 10;
healthBar.y = 10;
this.addChild(healthBar);

var scoreDisplay:ScoreDisplay = new ScoreDisplay();
scoreDisplay.x = 375;
scoreDisplay.y = 10;
this.addChild(scoreDisplay);

stage.addEventListener ( MouseEvent.MOUSE_DOWN, reticle.doMouseDown, false, 0, true);
stage.addEventListener ( MouseEvent.MOUSE_UP, reticle.doMouseUp, false, 0, true);
reticle.addEventListener ( Event.ENTER_FRAME, reticle.onFrame, false, 0, true);
game.addEventListener ( Event.ENTER_FRAME, game.onFrame, false, 0, true);
game.hero.addEventListener(Event.ENTER_FRAME,game.hero.onFrame, false, 0, true);
stage.addEventListener(Event.ENTER_FRAME, fcEnemies.onFrame, false, 0, true);

// sof diagnostics
function checkMemoryUsage():void {
	//trace("== MEM: " + System.totalMemory + "==");
	//trace("== OBJECTS: ==");TimelineUtils.dispTree(game, 0);
	trace("== OBJECTS: ==");
	trace(TimelineUtils.countTree(game));
	//trace("== GAME SIZE: ==" + getSize(game));
}

if(Config.DIAGNOSTICS) {
	var frt:FramerateTracker = new FramerateTracker(stage.frameRate);
	this.addChild(frt);
	// enable the next line to track memory usage
	var checkMemoryIntervalID:uint = setInterval(checkMemoryUsage,1000);
}
// eof

stop();