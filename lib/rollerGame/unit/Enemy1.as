package rollerGame.unit {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import flash.events.Event;
	import rollerGame.env.GameMgr;
	import rollerGame.env.GameField;
	import rollerGame.env.BattleSence;
	import rollerGame.env.RootData;
	import rollerGame.util.MyLine;
	import rollerGame.util.Math2;
	import rollerGame.unit.Unit;
	import rollerGame.data.Motion;
	
	public dynamic class Enemy1 extends Unit {
//		public var spd:Number = 1.5 /4;
		public var spd:Number = 1.5;
		public var r_delay_spd:Number = 1 / 15;
		
		private var think_kehai:Boolean = false;
		private var tar_p:Point = null;
		private var tar_p_timer:Number = 0;
		private var tar_p_timer_max:Number = 60 * 2;
		
		private var wait_timer:Number = 0;
		private var wait_timer_max:Number = 60;
		
		private var p_no:Number = 0;
		private var l_no:Number = 0;
		
		public static var _motionHolder:Array = [
			new Motion( "appe" ),
			new Motion( "run", Motion.ENDJUMP_LOOP ),
			new Motion( "light", Motion.ENDJUMP_DEFAULT ),
			new Motion( "damage" ),
			new Motion( "dead", Motion.ENDJUMP_STOP )
		];

		public function Enemy1() {
			pow = 5;
			lifeMax = life = 3*10;
			money = 10;
			motionHolder = _motionHolder.slice();
		}
		public override function init():void 
		{
			var p:MovieClip = GameMgr.player;
			rotation = Math2.getAngle( x, y, p.x, p.y );
			tar_p = new Point( p.x, p.y );
		}
		
		public override function normalAction() {
			if ( currentLabel == "appe" ) return;
			if ( currentLabel == "damage" ) return;
			if ( deadfg ) return;
		
			var sn:Number = BattleSence(GameField.battleSence).rootData.stageNo -1;
			var str:String = RootData.connect[sn][l_no][p_no];
			var tar_p:Point = MyLine(BattleSence(GameField.battleSence).rootData[str]).left;
			tar_p = parent.globalToLocal(tar_p);
			
			//ターゲットの方向に向かう
			var ang:Number = Math2.getAngle( x, y, tar_p.x, tar_p.y );
			var dx = spd * (think_kehai?1.5:1) * Math2.cos(ang);
			var dy = spd * (think_kehai?1.5:1) * Math2.sin(ang);
			if ( Math.abs( tar_p.x - x ) < Math.abs(dx) ) dx = tar_p.x - x;
			if ( Math.abs( tar_p.y - y ) < Math.abs(dy) ) dy = tar_p.y - y;
			GameMgr.topo.clipRay(this, x + dx, y + dy );
			
			if ( Math.abs(x - tar_p.x) <= 1 && Math.abs(y - tar_p.y) <= 1 )
				// 到達したら、次のポイントへ・・・
				p_no = Math.min(p_no + 1, RootData.connect[sn][l_no].length - 1);

			if ( !( dx == 0 && dy == 0 ) ) rotation += Math2.getRoundRange(rotation, ang) * r_delay_spd;
		}
		
/*		
		public override function normalAction() {
			if ( currentLabel == "appe" ) return;
			if ( currentLabel == "damage" ) return;
			if ( deadfg ) return;
			

			// 気配をサーチ
			if ( Math2.getRange( x, y, GameMgr.player.x, GameMgr.player.y ) < 100) {
				if ( Math.abs( Math2.getRoundRange( GameMgr.player.rotation, rotation ) ) < 180 ) {
					// 気配へ振り向く
					tar_p = new Point(GameMgr.player.x, GameMgr.player.y);
					tar_p_timer = 0;
					wait_timer = 0;
					think_kehai = true;
				}
			}
			
			// ターゲットがいない…
			if ( tar_p == null ) {
				// １秒待ち
				wait_timer++;
				if ( wait_timer > wait_timer_max ) {
					wait_timer = 0;
					// ターゲットの決定
					// 3分の1の確立（0:90右,1:90左,3:真後ろ)
					var rand = Math.floor(Math.random() * 3);
					var rate;
					switch (rand) 
					{
						case 0: rate = (rotation - 90) * Math2.CRAG; break;
						case 1:	rate = (rotation + 90) * Math2.CRAG; break;
						case 2:	rate = (rotation + 180) * Math2.CRAG;	break;
					}
					tar_p = new Point(x * Math.cos(rate) * 1000, y * Math.sin(rate) * 1000);
				}
			}
			else {
				//ターゲットの方向に向かう
				var ang:Number = Math2.getAngle( x, y, tar_p.x, tar_p.y );
				var dx = spd * (think_kehai?1.5:1) * Math2.cos(ang);
				var dy = spd * (think_kehai?1.5:1) * Math2.sin(ang);
				if ( Math.abs( tar_p.x - x ) < Math.abs(dx) ) dx = tar_p.x - x;
				if ( Math.abs( tar_p.y - y ) < Math.abs(dy) ) dy = tar_p.y - y;
				GameMgr.topo.clipRay(this, x + dx, y + dy );
				
				if ( !( dx == 0 && dy == 0 ) ) rotation += Math2.getRoundRange(rotation, ang) * r_delay_spd;
				
				// 2秒経つといったんターゲットを忘れる
				tar_p_timer++;
				if ( tar_p_timer > tar_p_timer_max ) {
					tar_p = null;
					tar_p_timer = 0;
					wait_timer = 0;
					think_kehai = false;
				}
			}
		}
*/		
	}
}