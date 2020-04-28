package rollerGame.attack {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import flash.events.Event;

	import rollerGame.util.Input;
	import rollerGame.env.GameMgr;
	import rollerGame.env.GameField;
	
	public dynamic class ShotA extends MovieClip{
		var spd:Number = 10;
		var time:Number = 0;
		var set_time:Number = 30;
		var sig:Sight = new Sight;
		var seShot:SE_Shot = new SE_Shot;
		public function ShotA() {
			GameMgr.field.addChild(sig);
			
			addEventListener( Event.ENTER_FRAME, en );
			function en(e:Event):void {
				
				// ターゲットいないなら無反応
				if ( sig.tar == null ) return;
				
				time++;
				if ( set_time < time ) {
					if ( Input.mouseDown ) return;
					if ( !Input.mouseDown ) return;
					
					var t:Tama = new Tama();
					// 照準のターゲットアングルに速度(spd)で照射
//					t.seting(sig.tAng, spd);
					t.seting(GameMgr.player.rotation, spd);
					t.x = GameMgr.player.x;
					t.y = GameMgr.player.y;
					GameField.shotField.addChild(t);

					t = new Tama();
					// 照準のターゲットアングルに速度(spd)で照射
//					t.seting(sig.tAng-30, spd);
					t.seting(GameMgr.player.rotation-30, spd);
					t.x = GameMgr.player.x;
					t.y = GameMgr.player.y;
					GameField.shotField.addChild(t);
					
					t = new Tama();
					// 照準のターゲットアングルに速度(spd)で照射
//					t.seting(sig.tAng+30, spd);
					t.seting(GameMgr.player.rotation+30, spd);
					t.x = GameMgr.player.x;
					t.y = GameMgr.player.y;
					GameField.shotField.addChild(t);
					
					seShot.play();

					
					time = 0;
				}

			}
		}		
	}
}
