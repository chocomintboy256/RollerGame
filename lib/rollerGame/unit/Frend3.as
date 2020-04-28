package rollerGame.unit {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import flash.events.Event;
	import rollerGame.env.GameMgr;
	import rollerGame.util.Math2;
	
	import rollerGame.data.Motion;
	
	
	public class Frend3 extends Unit {
		public var mouseRange:Number;
		public var playerRange:Number;
		public var spd:Number;
		public var maxKyori:Number;
		public static var _motionHolder:Array = [
			new Motion( "appe" ),
			new Motion( "run", Motion.ENDJUMP_LOOP ),
			new Motion( "light" ),
			new Motion( "damage" ),
			new Motion( "dead", Motion.ENDJUMP_STOP )
		];
		
		public function Frend3() {
			
			playerRange = 50*2;
			spd = 2;
			maxKyori = 100;
			pow = 1;
			lifeMax = life = 10;
			money = 20;
			
			x = 100;
			y = 100;
			
			motionHolder = _motionHolder.slice();
			switchAction("run");

		}

		public override function normalAction() {
			if ( currentLabel == "appe" ) return;
			if ( currentLabel == "damage" ) return;
			if ( deadfg ) return;

			//プレイヤーの方向に向かう
			var ang:Number;
			var p:MovieClip = GameMgr.player;
			
			ang = Math2.getAngle( x, y, p.x, p.y );
			x += spd * Math2.cos(ang);
			y += spd * Math2.sin(ang);
			
//			rotation = ang;
			var r = Math2.getRoundRange(rotation + 0, ang);
			rotation += r * 0.25 /10;
		}

	}
}
