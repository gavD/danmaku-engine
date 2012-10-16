package uk.co.gavd.danmakuengine.enemies {
	import uk.co.gavd.danmakuengine.ballistics.firingstrategies.Circle;
	import uk.co.gavd.danmakuengine.ballistics.firingstrategies.FiringPattern;
	import uk.co.gavd.danmakuengine.Game;
	import uk.co.gavd.danmakuengine.ballistics.*;
	import flash.display.*;
	import flash.events.Event;
	import flash.media.Sound;
	import uk.co.gavd.danmakuengine.ballistics.firingstrategies.SpinTriplet;

    public class Guardian4 extends Guardian {
		
		public function Guardian4() {
			super();
			
			this.fireRange = 800;
			this.scoreForKill = 600;
			this.rateOfFire = 9;
			this.hp = 400;
			
			this.fireSound = new BulletGuardian1Wav();	
		}
		
		override public function setGame(game:Game):void {
			
			super.setGame(game);
			this.firePatterns.push(new SpinTriplet(this.game, this, 7,	2, -40));
			this.firePatterns.push(new SpinTriplet(this.game, this, 7,	2, -20));
			this.firePatterns.push(new SpinTriplet(this.game, this, 7,	2, 0));
			
			this.firePatterns.push(new SpinTriplet(this.game, this, 7, -2, 0));
			this.firePatterns.push(new SpinTriplet(this.game, this, 7, -2, 20));
			this.firePatterns.push(new SpinTriplet(this.game, this, 7, -2, 40));
			
			this.firePatterns.push(new Circle(this.game, this, 70, 1, 0, 6));
			
			this.firePatternCount = firePatterns.length;
		}
    }
}