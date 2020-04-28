package rollerGame.attack {
	//
	// サイト（照準）クラス
	//
	//-----------------------
	// 機能:一番近いターゲットを狙う

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import flash.events.Event;
	import rollerGame.env.GameMgr;
	import rollerGame.util.Math2;
	
	public dynamic class Sight extends MovieClip {
		var tar:MovieClip;
		var tAng:Number = 0;
		
		var time:Number = 0;
		const refRate:Number = 1;
		
		var pRangeMax:Number = 30;
		
		public function Sight() {
			
			// subject : 常駐処理
			//----------------------------------------
			// details : 
			//	refRate間隔でターゲット(tar)を更新
			//	ターゲット(tar)に移動
			
			addEventListener(Event.ENTER_FRAME, en);
			function en(e:Event):void
			{
				// ターゲット更新
				time++;
				if ( time >= refRate ) {
					time = 0;
					refTarget();
				}
				
				// ターゲットに移動
				moveToTarget();
			}

			//ターゲットに移動
			function moveToTarget():void {

				if ( tar == null ) return;
				
				tAng = Math2.getAngle( GameMgr.frend[1].x, GameMgr.frend[1].y, tar.x, tar.y);
				
				if ( Math.abs(tar.x - x) >= 1 ) {
					x += (tar.x - x) * 0.125;
				}
				else {
					x = tar.x;
				}
				
				if ( Math.abs(tar.y - y) >= 1 ) {
					y += (tar.y - y) * 0.125;
				}
				else {
					y = tar.y;
				}	
/*			
				var p = GameMgr.player;
				var k = Math2.getRange(p.x, p.y, x, y );
				var ang = Math2.getAngle(p.x, p.y, x, y);
*/
				//後ろに照準
/*				sig.ang = ang;
				if ( k > pRangeMax ) {
					sig.x = p.x + Math.cos(ang * Math2.CRAG) * sigRangeMax;
					sig.y = p.y - Math.sin(ang * Math2.CRAG) * sigRangeMax;
				}*/
				
				/*
				// 前に照準
				sig.ang = -p.rotation;
				sig.x = p.x + Math.cos(p.rotation * Math2.CRAG) * sigRangeMax;
				sig.y = p.y + Math.sin(p.rotation * Math2.CRAG) * sigRangeMax;
				*/
			}
		}
		
		// 一番近いターゲットを更新
		function refTarget():void
		{
			var a1 = new Array;
			a1 = GameMgr.enemy.slice();
			a1.sort(tikaiObj);

			tar = a1.shift();
		}
		
		// 近い オブジェクトソート
		function tikaiObj(obj1, obj2):int
		{
			var f = GameMgr.frend;
			
			// 菱形 距離判定
			var r1 = Math.abs(f.x-obj1.x) + Math.abs(f.y-obj1.y);
			var r2 = Math.abs(f.x-obj2.x) + Math.abs(f.y-obj2.y);
			// 円 距離判定
			//var r1 = Math.sqrt(Math.pow(p.x-obj1.x,2) + Math.pow(p.y-obj1.y,2));
			//var r2 = Math.sqrt(Math.pow(p.x-obj2.x,2) + Math.pow(p.y-obj2.y,2));
			
			if (r1 < r2)
			{
				return -1; 
			}
			else if (r1 > r2) 
			{
				return 1; 
			}
			else
			{
				return 0; 
			}
		}
	}
}
