package rollerGame.unit {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import flash.events.Event;	
	import rollerGame.env.GameMgr;
	import rollerGame.util.Math2;
	
	public dynamic class Enemy4 extends Unit {
		public var spd:Number = 1 /4;
		public var dx, dy:Number;
		public function Enemy4() {
			lifeMax = life = 100;
			weigh = 10;
		}
		public override function init():void {
			//プレイヤーの方向に向かう
			var ang = Math2.getAngle( x, y, GameMgr.frend[0].x, GameMgr.frend[0].y );
			dx = spd * Math.cos(ang * Math2.CRAG);
			dy = spd * Math.sin(ang * Math2.CRAG);
			rotation = ang;
		}
		public override function normalAction() {
			if ( deadfg ) return;

			x += dx;
			y += dy;
		}
	}
}
