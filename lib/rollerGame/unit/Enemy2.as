package rollerGame.unit {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;	
	import flash.geom.Point;
	import flash.utils.Timer;

	import rollerGame.attack.Tama;
	import rollerGame.env.GameMgr;
	import rollerGame.env.GameField;
	import rollerGame.util.Math2;
	import rollerGame.data.Motion;
	
	public dynamic class Enemy2 extends Unit {
		public static const spd:Number = 0.05 /4;
		public static const maxMoveRange:Number = 100;
		public static const maxRange:Number = 300;
		public static var _motionHolder:Array = [
			new Motion( "appe" ),
			new Motion( "run", Motion.ENDJUMP_LOOP ),
			new Motion( "light", Motion.ENDJUMP_DEFAULT ),
			new Motion( "damage" ),
			new Motion( "dead", Motion.ENDJUMP_STOP )
		];
		
		public function Enemy2() {
			lifeMax = life = 2;
			money = 20;
			motionHolder = _motionHolder.slice();			
		}
		public override function init():void 
		{
			var p:MovieClip = GameMgr.player;
			rotation = Math2.getAngle( x, y, p.x, p.y );
		}
		// 
		
		public override function normalAction() {
			if ( currentLabel == "appe" ) return;
			if ( currentLabel == "damage" ) return;
			if ( deadfg ) return;
		
			// ターゲットに近づく
			// ターゲットの方向に玉を出す
			var mx:Number, my:Number;
			var ang:Number;
			var tar:Unit = GameMgr.player;
			
			ang = Math2.getAngle( x, y, tar.x, tar.y );
			var k = Math2.getRange( x, y, tar.x, tar.y );
			
			// ターゲットまでまだ遠い？
			if ( k > maxRange ) {
				
				// 移動量を絞って
				if ( k < -maxMoveRange ) k = -maxMoveRange;
				if ( k > maxMoveRange ) k = maxMoveRange;
				
				// 移動
				mx = k * spd * Math.cos(ang * Math2.CRAG);
				my = k * spd * Math.sin(ang * Math2.CRAG);
				GameMgr.topo.clipRay(this, x + mx, y + my );
			}
			else {
				if ( currentLabel == "run" ) {
					switchAction("light");
				}
			}
			rotation = ang;
		}
		
		public override function setWep( ... args):void 
		{
			var ang:Number;
			var tar:Unit = GameMgr.player;
			var p:Point = Math2.getFieldPoint(args[0]);
			
			ang = Math2.getAngle( p.x, p.y, tar.x, tar.y );
			
			// ターゲットの方向に玉を出す
			var t:Tama = new Tama();
			t.seting( ang, 3*2 );
			t.x = p.x;
			t.y = p.y;
			GameField.shotField.addChild(t);
			
		}
	}
}
