package rollerGame.unit {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import flash.events.Event;	
	import rollerGame.env.GameMgr;
	import rollerGame.env.GameField;
	import rollerGame.util.Math2;
	import rollerGame.data.Motion;
	import rollerGame.attack.Tama;
	
	
	public dynamic class Enemy3 extends Unit {
		public static const spd:Number = 0.05 /4;
		public static const maxMoveRange:Number = 350;
		public var time:int = 120;
		public var limtime:int = 120;
		public var okx:int = 0;
		public var oky:int = 0;
		public var ok:int = 0;
		
		public var timSP1:Timer = new Timer(2000, 6);
		public static var _motionHolder:Array = [
			new Motion( "appe" ),
			new Motion( "run", Motion.ENDJUMP_LOOP ),
			new Motion( "damage" ),
			new Motion( "sp1", Motion.ENDJUMP_STOP )
		];
		public function Enemy3() {
			lifeMax = life = 3;
			motionHolder = _motionHolder.slice();
			
			timSP1.addEventListener(TimerEvent.TIMER, onTickSP1);
			timSP1.addEventListener(TimerEvent.TIMER_COMPLETE, onCompSP1);
		}
		public override function init():void 
		{
			var p:MovieClip = GameMgr.player;
			rotation = Math2.getAngle( x, y, p.x, p.y );			
		}
		public override function normalAction() {
			if ( deadfg ) return;
			if ( currentLabel == "appe" ) return;
			if ( currentLabel == "sp1" ) {
				if ( !timSP1.running ) timSP1.start();
				return;
			}
			if ( currentLabel == "damage" ) return;
			
			//プレイヤーの方向に向かう
			var ang:Number;
			var p:MovieClip = GameMgr.player;
			
			if ( time++ > limtime ) {
				time = 0;
				ang = Math2.getAngle( x, y, p.x, p.y );
				ok = maxMoveRange;	//Math2.getRange( x, y, p.x, p.y );
				if ( ok < -maxMoveRange ) ok = -maxMoveRange;
				if ( ok > maxMoveRange ) ok = maxMoveRange;
				okx = x + ok * Math.cos(ang * Math2.CRAG);
				oky = y + ok * Math.sin(ang * Math2.CRAG);
				rotation = ang;
			}
			
			ang = Math2.getAngle( x, y, okx, oky );
			var k = Math2.getRange( x, y, okx, oky );
			x += k * spd * Math.cos(ang * Math2.CRAG);
			y += k * spd * Math.sin(ang * Math2.CRAG);
		}
		
		public function onTickSP1(event:TimerEvent):void 
		{
			var ang:Number;
			var tar:Unit = GameMgr.player;
			
			ang = Math2.getAngle( x, y, tar.x, tar.y );
			/*
			// ターゲットの方向に玉を出す
			var t:Tama = new Tama();
			t.init( ang, 3 );
			t.x = x;
			t.y = y;
			GameField.shotField.addChild(t);

			t = new Tama();
			t.init( ang+30, 3 );
			t.x = x;
			t.y = y;
			GameField.shotField.addChild(t);

			t = new Tama();
			t.init( ang-30, 3 );
			t.x = x;
			t.y = y;
			GameField.shotField.addChild(t);
			*/
			// 玉の速度を早める
			timSP1.delay = 1000;
		}
		public function onCompSP1(event:TimerEvent):void 
		{
			// 死亡状態がないので即消滅…
			this.deletefg = true;
		}		
	}
}
