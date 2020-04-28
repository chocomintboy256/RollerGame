package rollerGame.unit.action 
{
	import flash.geom.Point;
	import rollerGame.env.GameMgr;
	import rollerGame.env.GameField;
	import rollerGame.unit.Unit;
	import rollerGame.util.Input;
	import rollerGame.util.Math2;
	
	import rollerGame.unit.Player;
	import rollerGame.unit.Frend1;
	import rollerGame.unit.Frend2;
	import rollerGame.unit.Frend3;
	
	public class playerAction
	{
		// プレイヤーアクション
		public var burstFg:Boolean = false;
		public var u:Unit;

		private static const MOUSE_FREE_RANGE:Number = 5;
		private static const MIN_MOVE_RANGE:Number = 2;
		private	static const MAX_MOVE_RANGE:Number = 100;
		private static const MOVE_SPD:Number = 0.05*0.8;//*1.5;
		private static const MOVE_ROUND_SPD:Number = 0.25*2;
		
		
		public var tagertPos = new Point(100, 100);
		public var douryoku = 0;
		public function playerAction(u:Unit):void 
		{
			this.u = u;
		}
		public function go():void 
		{
			var ang:Number;
			
			// コイン回収
			coinPull.pulling();
			
			// 移動先更新(アグレッシブモード時のみ)
			if ( u.battleMode == u.BATTLE_MODE_AGGRESSIVE ) {
				tagertPos.x = GameMgr.field.mouseX;
				tagertPos.y = GameMgr.field.mouseY;
			}
			
			
			with (u)
			{
				ang = Math2.getAngle( x, y, tagertPos.x, tagertPos.y );
				if ( Input.mouseTrg == Input.TRG_DOWN ) {
					if ( battleMode == BATTLE_MODE_AGGRESSIVE ) {
						if ( u is Frend1 ) switchAction("special");
						else battleMode = BATTLE_MODE_PASSIVE;
						
//						GameField.insScrEffZoom.rePlay(u);
					}
					else {	// パッシブ時
						
						// 近ければ、アグレッシブ
						if ( Math2.getRange( x, y, GameMgr.field.mouseX, GameMgr.field.mouseY ) < 50 ) {
							battleMode = BATTLE_MODE_AGGRESSIVE;
	//						GameField.insScrEffZoom.stop();
						}
						
					}
					// フレームアニメ変更(maker)
					maker.gotoAndStop(battleMode);
					rangeMaker.gotoAndStop(battleMode);
				}
				
				if ( battleMode == BATTLE_MODE_AGGRESSIVE ) {
					// 等倍速+マウス追従
					if ( u is Frend1 ) move(ang, MOVE_SPD, 0, MOVE_ROUND_SPD/2);
					else move(ang, MOVE_SPD, 0, MOVE_ROUND_SPD);
				}
				else {
					// 等倍速+マウス追従
					move(ang, MOVE_SPD*2, 0, MOVE_ROUND_SPD);	
				}
			}
			
			/* インプットコードタイプ：バーストモード
			with (u)
			{
				ang = Math2.getAngle( x, y, GameMgr.field.mouseX, GameMgr.field.mouseY );
				if ( Input.mouseTrg == Input.TRG_DOWN ) this.burstFg = !this.burstFg;
				
				// 等倍速+マウス追従（バーストモード）
				if ( this.burstFg ) { mutekiTime = mutekiTimeMax;	move(ang, MOVE_SPD*3, 0, 0.25*2); }
				// 等倍速+マウス追従
				else {	move(ang, MOVE_SPD, 0, 0.25);	}
			}
			*/
		}
		
		private function move( ang:Number, speed:Number, rot:Number, rspd:Number ) {
			var k:Number;
			var r:Number;
			
			if ( !(u is Frend2) ) douryoku = 1;
			
			with (u) 
			{
				if ( u is Player ) {
					if ( !(currentLabel == "run" || currentLabel == "light") ) return;
				}
				else if ( u is Frend2 ) {
					if ( currentLabel != "light" ) douryoku = 1;
					
					if ( !(currentLabel == "run" || currentLabel == "light") ) return;
					if ( currentLabel == "light" ) 
						douryoku = Math.max( douryoku - 1/12, 0 );
				}
				else if ( u is Frend3 ) {
					if ( currentLabel != "light" ) douryoku = 1;
					
					if ( !(currentLabel == "run" || currentLabel == "light") ) return;
					if ( currentLabel == "light" ) 
						douryoku = Math.max( douryoku - 1/6, 0 );
				}
				else {
					if ( !(currentLabel == "run" || currentLabel == "light" ) ) return;
				}
				
				k = Math.abs( Math2.getRange( x, y, tagertPos.x, tagertPos.y )) * douryoku;

				k -= MOUSE_FREE_RANGE;
				if ( k < MIN_MOVE_RANGE ) return;
				if ( k > MAX_MOVE_RANGE ) k = MAX_MOVE_RANGE;

				// 移動処理
//				x += k * Math2.cos(ang) * speed;
//				y += k * Math2.sin(ang) * speed;
				GameMgr.topo.clipRay(u, x + (k * Math2.cos(ang) * speed), y + (k * Math2.sin(ang) * speed) );

				r = Math2.getRoundRange(rotation + rot, ang);
				rotation += r * rspd;
			}
		}
	}
}

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
class coinPull {
	public static var coinPullRange:Number = 100;
	public static var coinPullPow:Number = 20;
	public static var seGet = new SE_Get;
	function coinPull():void 
	{
	}
	public static function pulling():void 
	{
		var mf:MovieClip = GameField.moneyField;
		var p:Unit = GameMgr.player;
		var c:Coin;
		var i:int = 0;
		while ( i < mf.numChildren ) {
			c = mf.getChildAt(i) as Coin;
			if ( Math2.getRange(c.x, c.y, p.x, p.y) < coinPullRange ) {
				// 回収
				if ( Math.abs(c.x - p.x) < coinPullPow 
						&& Math.abs(c.y - p.y) < coinPullPow ) {
					GameMgr.player.money += c.value;
					seGet.play();
					c.del();
					continue;
				}
				// 引き寄せ
//				c.x += coinPullPow * (c.x < p.x ? 1 : -1);
//				c.y += coinPullPow * (c.y < p.y ? 1 : -1);
			}
			//--- Nextループ
			i++;
		}
	}
}