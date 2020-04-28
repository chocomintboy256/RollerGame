package rollerGame.unit {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import flash.events.Event;
	import rollerGame.env.GameMgr;
	import rollerGame.util.Math2;
	
	import rollerGame.data.Motion;
	
	public class Frend1 extends Unit {
		public var playerRange:Number;
		public var spd:Number;
		public var maxKyori:Number;
		public var range:MovieClip = null;

		public static var _motionHolder:Array = [
			new Motion( "appe" ),
			new Motion( "run", Motion.ENDJUMP_LOOP ),
			new Motion( "light" ),
			new Motion( "special", Motion.ENDJUMP_DEFAULT ),
			new Motion( "damage" ),
			new Motion( "dead", Motion.ENDJUMP_STOP )
		];
		public function Frend1() {
			
			playerRange = 50;
			spd = 0.05;
			maxKyori = 100;
			pow = 5;
			lifeMax = life = 5;
			money = 30;
			
			x = 100;
			y = 100;
			
			motionHolder = _motionHolder.slice();
			switchAction("run");
			
		}
		
		public override function normalAction() {
			if ( deadfg ) return;
			if ( currentLabel == "appe" ) return;
			if ( currentLabel == "damage" ) return;

/*			// プレイヤー行動
			var ang:Number;
			ang = Math2.getAngle( x, y, -(Math.cos(GameMgr.player.rotation * Math2.CRAG) * 30) + GameMgr.player.x,
										-(Math.sin(GameMgr.player.rotation * Math2.CRAG) * 30) + GameMgr.player.y );
					
					// 等倍速+マウス追従
					move(ang, spd, 0, 0.25);
*/
		}

		function move( ang:Number, spd:Number, rot:Number, rspd:Number ) {
			
//			var k = Math.abs( Math2.getRange( x, y, GameMgr.player.x, GameMgr.player.y )) - playerRange;
			
			// プレイヤー行動
			var k = Math.abs( Math2.getRange( x, y, -(Math.cos(GameMgr.player.rotation * Math2.CRAG) * 30)+GameMgr.player.x,
										-(Math.sin(GameMgr.player.rotation * Math2.CRAG) * 30)+GameMgr.player.y ));

			if ( k > maxKyori ) k = maxKyori;
			if ( k < -maxKyori ) k = -maxKyori;
			
			if ( Math.abs(k) >= 2 ) {

				x += (k * Math.cos(ang * Math2.CRAG))*spd;
				y += (k * Math.sin(ang * Math2.CRAG))*spd;

				var r = Math2.getRoundRange(rotation + rot, ang);
				rotation += r * rspd;
			}
		}
	}
}
