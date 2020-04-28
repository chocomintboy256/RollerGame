package rollerGame.unit {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import flash.events.Event;
	import rollerGame.env.GameMgr;
	import rollerGame.util.Math2;
	
	public dynamic class Enemy5 extends Unit {
		public var spd:Number = 3 /4;
		public function Enemy5() {
		}
		public override function init():void {
			lifeMax = life = 5;
		}
		public override function normalAction() {
			if ( deadfg ) return;
			
			var ang:Number;
			var p:MovieClip = GameMgr.frend[0];
			
			ang = Math2.getAngle( x, y, p.x, p.y );
			x += spd * Math.cos(ang * Math2.CRAG);
			y += spd * Math.sin(ang * Math2.CRAG);
			rotation = ang;
		}
	}
}
