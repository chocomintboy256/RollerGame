package rollerGame.env {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Timer;
	import rollerGame.console.Console;
	import rollerGame.console.Combo;
	import rollerGame.unit.Enemy2;

	import flash.events.Event;
	
	import rollerGame.util.Math2;
	import rollerGame.util.Input;
	import rollerGame.attack.ShotA;
	import rollerGame.unit.Unit;
	import rollerGame.unit.Player;
	import rollerGame.unit.Frend1;
	import rollerGame.unit.Frend2;
	import rollerGame.unit.Frend3;
	import rollerGame.attack.Tama;
	
	import rollerGame.env.HyoukaForm;
	import com.flashdynamix.motion.Tweensy;
	import com.flashdynamix.motion.TweensyGroup;
	
	public class GameMgr extends MovieClip {
		public static var field:GameField;
		public static var console:Console;
		public static var topo:Topography;
		public static var player:Unit;
		public static var frend:Array;
		public static var enemy:Array;
		public static var trap:Array;
		
		public var appe:Appearance;
		
		public static var hitCount:Number;
		public static var smashCount:Number;
		
		public static var t:TextField = new TextField();
		public static var t2:TextField = new TextField();
		public static var tf:TextFormat = new TextFormat(null, 30);
		public static var endfg:Boolean = false;
		public static var count:int = 0;
		
		public static var msg_win = "現れる敵を５０体倒せ！";
		public static var msg_lose = "ライフが０になるとＧａｍｅＯｖｅｒ・・・";
		
		public var timer:Timer = new Timer(1000, 60*3);
		public var tg:TweensyGroup = new TweensyGroup();
		
		public function GameMgr() {
			hitCount = 0;
			smashCount = 0;
		
			frend = new Array;
			enemy = new Array;
			trap = new Array;

			
			t = new TextField();
			t2 = new TextField();
			tf = new TextFormat(null, 30);
			endfg = false;
			count = 0;
			msg_win = "現れる敵を５０体倒せ！";
			msg_lose = "ライフが０になるとＧａｍｅＯｖｅｒ・・・";			
		}
		
		public function init(unitNo:Number) {
			
				// ストップ
				
				// 評価
				
				// Next ? End
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, f1);
			function f1(e:TimerEvent) {
				msg_lose = timer.currentCount.toString();
				dispConsole();
				
				tg.contrastTo( GameField.battleSence, -0.4*(timer.currentCount/timer.repeatCount) );
			}
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, f2);
			function f2(e:TimerEvent) {
				var h:HyoukaForm = new HyoukaForm();
				h.addEventListener("SenceEnd", senceEndHandler);
				function senceEndHandler(e:Event):void
				{
					// 評価シーンが終われば、ゲームシーン終了のお知らせ
					GameField.battleSence.dispatchEvent(new Event("SenceEnd"));
				}
				GameField.battleSence.addChild( h );
				removeEventListener(Event.ENTER_FRAME, main_loop);
				
			}
			
			
		
			//
			//-- 素材召集
			//
			field = GameField.instance;
			console = Console.instance;
			console.combo.addEventListener(Combo.TIMER_END, comboTimerEnd );
			function comboTimerEnd(event:Event):void 
			{
				hitCount = 0 ;
				smashCount = 0;
			}
			topo = new Topography();
			
			switch ( unitNo ) {
				case 0:	
					player = Player(UnitMgr.create(getQualifiedClassName(Player)));
					frend.push( player );
					break;
				case 1:
					frend.push( Frend2(UnitMgr.create(getQualifiedClassName(Frend2))) );
					player = frend[frend.length-1];
					break;
				case 2:
					frend.push( Frend1(UnitMgr.create(getQualifiedClassName(Frend1))) );
					player = frend[frend.length-1];
					break;
			}
			
			player.playerFlag = true;
			frend.push( Frend3(UnitMgr.create(getQualifiedClassName(Frend3))) );
			frend[frend.length-1].playerFlag = true;
			frend[frend.length-1].battleMode = player.BATTLE_MODE_PASSIVE;
			
/* 			frend.push( Frend2(UnitMgr.create(getQualifiedClassName(Frend2))) );
*/
			appe = new Appearance();

			// コンソール初期化
			setConsole("init");
			
			// メインループ開始
			addEventListener( Event.ENTER_FRAME, main_loop );
					
		}
		
		//
		//--- メインループ
		//
		public function main_loop(event:Event):void {
					
			// ユニット行動
			for each (var f in frend) { f.proc(); }
			for each (var e in enemy) { e.proc(); }
			for each (var t in trap) { t.proc(); }
			
			// ユニット各種判定
			for each ( f in frend) 
			{
				actionCheck(f,enemy);	// アクションチェック
				damageCheck(f);			// ダメージチェック	torap tama
				attackCheck(f,enemy);	// 攻撃チェック
			}
			for each ( e in enemy) 
			{
				actionCheck(e,frend);	// アクションチェック
				damageCheck(e,false);	// ダメージチェック	torap tama
				attackCheck(e,frend);	// 攻撃チェック
			}
			
			// 出現物 死亡登録
			appe.delRegist();

			// プレイヤー死亡
			
			// 敵出現
			appe.proc();
			
			// ゲーム終了チェック
			endCheck();
			
			
			//---------------
			//-- 描画
			//---------------
			
			// ゲージ
			UnitMgr.gaugeDisp();
			// コンソール
			dispConsole();
			
			Input.trgClear();
		}
		
		//
		//--- 終了チェック
		//
		public static function endCheck() {
			if ( endfg ) return;
			
			if ( count >= 50 ) {
				setConsole("win");
				endfg = true;
			}
			
			if ( player.deadfg ) {
				setConsole("lose");
				endfg = true;
			}
			
		}
		
		//
		//-- ダメージチェック
		//
		public static function damageCheck(u:Unit,fg:Boolean = true) {
			var dispMC:MovieClip = MovieClip(u.getChildAt(0));
			
			if ( u.deadfg ) return;
			if ( u.mutekiTime > 0 ) return;
			if ( dispMC.hit == null ) return;

			// Unit VS 玉(フラグがたってたら無視)
			var t:Tama;
			if ( fg ) {
				for ( var i = 0; i < GameField.shotField.numChildren; i++ ) {
					t = Tama(GameField.shotField.getChildAt(i));
					
					if ( t.hitTestObject( dispMC.hit ) ) {
						u.setHit(t);
						u.seDamage.play();
						t.del();
						break;
					}
				}
			}
			
			// Unit VS トラップ
			for each (var tr:Unit in trap) 
			{
				if ( MovieClip(tr).mc.atk == null ) continue;
				if ( dispMC.hit.hitTestObject( MovieClip(tr).mc.atk ) ) {
					u.setHit(tr);
					u.seDamage.play();
				}
			}
		}
		
		//
		//-- アクションチェック
		//
		public static function actionCheck(u:Unit,rival:Array) {
			var dispMC:MovieClip = MovieClip(u.getChildAt(0));
			if ( u.deadfg ) return;
			if ( dispMC.act == null ) return;
//			if ( u.battleMode == u.BATTLE_MODE_PASSIVE ) return;
			
			// Unit VS ライバル
			for each (var r:Object in rival) 
			{
				if ( r.deadfg ) continue;
				if ( r.mc.hit == null ) continue;
				//if ( r.mutekiTime > 0 ) continue;
				if ( dispMC.act.hitTestObject( r.mc.hit) ) {
					if ( Math2.roundHitCheck(dispMC.act, r.mc.hit) ) {
						u.switchAction();
						break;
					}
				}
			}
			
		}	
		
		//
		//-- アタックチェック
		//
		public static function attackCheck(u:Unit,rival:Array) {
			var dispMC:MovieClip = MovieClip(u.getChildAt(0));

			if ( u.deadfg ) return;
			
			// 飛び道具判定
			if ( dispMC.wep != null ) {
				u.setWep(dispMC.wep);
			}
			
			// 攻撃判定
			if ( dispMC.atk == null ) return;
			
			// Unit VS 敵
			for each (var r:Object in rival) {
				if ( r.deadfg ) continue;
				if ( r.mutekiTime > 0 ) continue;
				if ( r.mc.hit == null ) continue;
				
				if ( dispMC.atk.hitTestObject( r.mc.hit ) ) {
					if( Math2.roundHitCheck(dispMC.atk, r.mc.hit) ) {
						if ( !(u == GameMgr.player) ) u.seDamage.play();
						r.setHit(u);
					}
				}
			}
		}
		
		//
		//-- コンソール表示
		//
		function dispConsole() {
			if ( endfg ) {
				t2.text = "";
			}
			else {
				t2.text = "あと" + (50 - count) +"体\nプレイヤーライフ残り" + player.life;
				t2.appendText("\n[ " + player.money + " ]money\n" );
				t2.appendText("\n" + "残り時間:" + (60 - timer.currentCount ) );
//				t2.appendText("\n" + hitCount + "Hit!\n" + smashCount + "Smash!!" );
			}
			t2.setTextFormat(tf);
		}

		// コンソール情報更新
		public static function setConsole(msg:String = null) {
			
			t.visible = false;
			t2.visible = false;
			
			switch (msg)
			{
				case "win":
					t.text = "You Win";
					t.setTextFormat(tf);
					break;
					
				case "lose":
					t.text = "You Lose...";
					t.setTextFormat(tf);
					break;
					
				case "init":
					// 勝利条件表示
					t.text = msg_win +"\n" + msg_lose;
					t.x = 0;
					t.y = 0;
					t.autoSize = TextFieldAutoSize.LEFT;
					t.background = true;
					t.backgroundColor = 0xFFFFFF;
					t.alpha = 0.5;
					t.setTextFormat(tf);
					field.addChild(t);
					
					// 勝利条件現状表示
					t2.text = "あと" + (50 - count) +"体";
					t2.x = 0;
					t2.y = 70;
					t2.autoSize = TextFieldAutoSize.LEFT;	
					t2.background = true;
					t2.backgroundColor = 0xFFFFFF;
					t2.alpha = 0.5;				
					t2.setTextFormat(tf);
					field.addChild(t2);
			}
			
		}
	}
}
