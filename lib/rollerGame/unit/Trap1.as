package rollerGame.unit {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import flash.events.Event;
	import rollerGame.env.GameMgr;
	import rollerGame.util.Math2;
	import rollerGame.unit.Unit;
	import rollerGame.data.Motion;
	
	public dynamic class Trap1 extends Unit {
//		public var spd:Number = 1.5 /4;
		public var spd:Number = 1.5;
		public var ang:Number;
		
		public static var _motionHolder:Array = [
			new Motion( "appe" ),
			new Motion( "run", Motion.ENDJUMP_LOOP ),
			new Motion( "dead", Motion.ENDJUMP_STOP )
		];

		public function Trap1() {
			lifeMax = life = 6;
			mutekiTime = 99999;
			motionHolder = _motionHolder.slice();
		}
		
		public override function normalAction() {
			if ( deadfg ) return;

			//プレイヤーの方向に向かう
			/*
			var ang:Number;
			var p:MovieClip = GameMgr.player;
			
			ang = Math2.getAngle( x, y, p.x, p.y );
			x += spd * Math.cos(ang * Math2.CRAG);
			y += spd * Math.sin(ang * Math2.CRAG);
			
			rotation = ang;
			*/
		}
	}
}