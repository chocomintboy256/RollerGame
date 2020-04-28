package rollerGame.unit {
	import com.flashdynamix.motion.TweensyTimeline;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import rollerGame.data.Coin;
	import rollerGame.data.Motion;

	import flash.events.Event;
	import rollerGame.env.GameMgr;
	import rollerGame.env.GameField;
	import rollerGame.util.Math2;
	import rollerGame.unit.Unit;
	import rollerGame.attack.ShotA;
	
	import rollerGame.util.Input;
	
	public class Player extends Unit {
		
		public var shot:ShotA;
		public var burstFg:Boolean = false;
				
		public static var _motionHolder:Array = [
			new Motion( "appe" ),
			new Motion( "run", Motion.ENDJUMP_LOOP ),
			new Motion( "light" ),
			new Motion( "middle" ),
			new Motion( "heavy" ),
			new Motion( "damage" ),
			new Motion( "dead", Motion.ENDJUMP_STOP )
		];
		
		public function Player() {
			pow = 5;
			skillLV = 1;
			life = lifeMax = 8;
			x = y = 100;
			
			motionHolder = _motionHolder.slice();
			switchAction("run");
		}
		
		public override function normalAction() {
			
			if ( deadfg ) return;
			if ( currentLabel == "appe" ) return;
			
			//プレイヤーの方向に向かう
			var ang:Number;
			var p:MovieClip = GameMgr.player;
			
			ang = Math2.getAngle( x, y, p.x, p.y );
			x += 2 * Math.cos(ang * Math2.CRAG);
			y += 2 * Math.sin(ang * Math2.CRAG);
			
			rotation = ang;
		}
	}
}
