package uk.co.gavd.danmakuengine.ballistics {
	import flash.display.MovieClip;
	import uk.co.gavd.danmakuengine.Game;
	
    public class BulletMissile extends Bullet {
		
		protected var turn:Number = 2;
		
    	public function BulletMissile(game:Game) {
			super(game);
			
			this.lSpeed = 5;
			this.rotateToFace = true;
			this.framesToLive = 120;
		}
		
		protected var target:MovieClip = null;
		
        override public function fireAtTarget(target:MovieClip):void {
			this.target = target;
			var radians:Number = this.getAngleTo(target.x - game.artifacts.x, target.y);
			this.rotation = (radians * (ONEEIGHTY_OVER_PI));
        }
		
		override public function fireAtPoint(targetX:Number, targetY:Number):void {
			throw new Error("missiles must be targeted");
		}
        
		override public function fireAtAngle(degrees:Number):void {
			throw new Error("missiles must be targeted");
		}
		
		override public function fireAtAngleRadians(radians:Number):void {
			throw new Error("missiles must be targeted");
		}
		
		override protected function moveTowardsTarget():void {
			
			super.moveTowardsTarget();
			
			var curRadians = this.rotation / ONEEIGHTY_OVER_PI;
			this.xTravel = lSpeed * Math.cos(curRadians);
			this.yTravel = lSpeed * Math.sin(curRadians);
			
			if (this.target === null || this.target.lAction !== 0)
			{
				return;
			}
			
			var targetRadians:Number = this.getAngleTo(target.x - game.artifacts.x, target.y);
			var targetRotation:Number = (targetRadians * (ONEEIGHTY_OVER_PI));
			
			var diff:Number  = targetRotation - this.rotation;
			while (diff > 180) {
		    	diff -= 360;
			}

			while (diff < -180) {
			   diff += 360;
			}
			
			this.rotation += (diff<0) ? (-turn) : (turn);
			
		}
		
    }
}