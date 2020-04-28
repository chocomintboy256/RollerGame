package rollerGame.unit {
	import rollerGame.data.Motion;
	import rollerGame.env.GameMgr;
	import rollerGame.env.GameField;
	import rollerGame.unit.action.playerAction;
	import rollerGame.util.Math2;
	import rollerGame.data.ActStateData;
	import rollerGame.data.Money;
	import flash.utils.getQualifiedClassName;
	import rollerGame.util.StageEffectShock;
	
	import rollerGame.data.Hit;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Unit extends MovieClip {	
		public var dataID:int;
		public var dispMC:MovieClip;
		public var state:Array = new Array( new ActStateData( ActStateData.ACT_ALERT ) );
		public var stateNow:uint = 0;
		
		public var deletefg:Boolean = false;
		public var deadfg:Boolean = false;
		public var life:int = 1;
		public var lifeMax:int = 1;
		public var money:int = 0;

		public var pow:int = 5;
		public var hitRefCount:int = 0;
		
		public var mutekiTime:int = 0;
		public const mutekiTimeMax:int = 5;
		
		public var hit:Hit;
		public var weigh:Number = 0.1;	// 重さ
		
		public var motionHolder:Array;	// モーション配列
		
		public var playerFlag:Boolean = false;	// プレイヤーフラグ
		public var pAction:playerAction;
		public var battleMode:uint = BATTLE_MODE_AGGRESSIVE;
		public const BATTLE_MODE_AGGRESSIVE:uint = 1;
		public const BATTLE_MODE_PASSIVE:uint = 2;
		
		public var seDamage:SE_Damage = new SE_Damage;
		public var seHit:SE_Hit = new SE_Hit;
		public var seKO:SE_KO = new SE_KO;
		
		public var animStatus:uint = ActStateData.ACT_ALERT;
		public var skillLV:Number = 0;
		public var skillEX:Number = 0;
		
		public function Unit() {
			dispMC = MovieClip(getChildAt(0));
			stop();
			pAction = new playerAction(this);
		}
		public function init():void  {}
		public function proc() {
			// 状態系統
		 	hitReaction();
			if ( mutekiTime > 0 ) {
				mutekiTime--;
			}
			
			// 動き系統
			actionControl();
			animControl();
		}
		public function actionControl()
		{
			if ( playerFlag ) pAction.go();
			else normalAction();
		}
		public function setWep( ... args ):void 
		{
			return;
		}
		
		public function normalAction(){}	// オーバーライド専用
		
		
		public function hitReaction() {
			var mx:Number, my:Number;
			
			if ( hit == null ) return;
			if ( hit.pow == 0 ) return;
			
			// hit パワー消費
			hit.pow -= weigh;
			if ( hit.pow > 1 ) {
				// リアクション
				mx = hit.pow * Math.cos(hit.ang * Math2.CRAG);
				my = hit.pow * Math.sin(hit.ang * Math2.CRAG);
				if ( GameMgr.topo.clipRay(this, x + mx, y + my ) ) {
					// hit パワー消滅
					hit.pow = 0;
					setHit(this);
//					if ( hitRefCount++ < 3 ) hit.pow = hit.pow * 1.5;
//					hit.ang = hit.ang + 180;
				}

			}
			else {
				// hit パワー消滅
				hit.pow = 0;
				hitRefCount = 0;
				return;
			}
		}
		
		public function setHit(attacker:InteractiveObject = null) {
			if ( attacker is Player ) {
				if ( MovieClip(attacker).currentLabel == "light" || MovieClip(attacker).currentLabel == "middle" ) {
					hit = new Hit(
								Unit(attacker).pow * (Math.floor(Math.random()*10 + 1) == 1?1:0),
								Math2.getAngle(attacker.x, attacker.y, x, y ),
								1,
								mutekiTimeMax,
								20
							);
				}
				else if ( MovieClip(attacker).currentLabel == "heavy" ) {
					hit = new Hit(
								Unit(attacker).pow * 1.5,
								Math2.getAngle(attacker.x, attacker.y, x, y ),
								3,
								mutekiTimeMax * 3,
								60,
								true
							);
				}
			}
			else if ( attacker is Enemy3 && MovieClip(attacker).currentLabel == "sp1" ) {
				hit = new Hit(
							0,
							Math2.getAngle(attacker.x, attacker.y, x, y ),
							1,
							mutekiTimeMax*3
						);				
			}
			else if ( attacker is Frend2 ) {
				if ( MovieClip(attacker).currentLabel == "light" ) {
					hit = new Hit(	
								Unit(attacker).pow/5,
								Math2.getAngle(attacker.x, attacker.y, x, y ),
								2,
								mutekiTimeMax * 3,
								15,
								true
							);
				}
				else if ( MovieClip(attacker).currentLabel == "middle" ) {
					hit = new Hit(	
								Unit(attacker).pow,
								Math2.getAngle(attacker.x, attacker.y, x, y ),
								2,
								mutekiTimeMax * 3,
								60,
								true
							);
				}
			}			
			else if ( attacker is Frend1 ) {
				if ( MovieClip(attacker).currentLabel == "light" ) {
					hit = new Hit(
								Unit(attacker).pow,
								Math2.getAngle(attacker.x, attacker.y, x, y ),
								1,
								mutekiTimeMax,
								10
							);
				}
				else if ( MovieClip(attacker).currentLabel == "special" ) {
					hit = new Hit(
								Unit(attacker).pow*1.5,
								Math2.getAngle(attacker.x, attacker.y, x, y ),
								5,
								mutekiTimeMax*2,
								10,
								true
							);
				}
			}
			else if ( attacker is Frend3 ) {
				if ( MovieClip(attacker).currentLabel == "light" ) {
					hit = new Hit(
								Unit(attacker).pow*2,
								Math2.getAngle(attacker.x, attacker.y, x, y ),
								1,
								0,
								0
							);
				}
			}
			else if ( attacker is Enemy1 ) {
				hit = new Hit(
							Unit(attacker).pow,
							Math2.getAngle(attacker.x, attacker.y, x, y ),
							1,
							mutekiTimeMax*3,
							15,
							true
						);
			}
			else if ( attacker == null ) {
				// 壁ヒット
				hit = new Hit(
							0,
							0,
							1,
							0,
							0,
							false
						);
			}
			else {
				hit = new Hit(
							Unit(attacker).pow,
							Math2.getAngle(attacker.x, attacker.y, x, y ),
							1,
							mutekiTimeMax,
							10
						);
			}
			
			// ヒットをカウント
			GameMgr.hitCount++;
			GameMgr.console.combo.setHit(GameMgr.hitCount);
			if ( hit.smash ) {
				GameMgr.smashCount++;
				GameMgr.console.combo.setSmash(GameMgr.smashCount);
			}

			seHit.play();
			if ( this.playerFlag ) StageEffectShock.ins.play();
			hitRefCount = 0;	// 反射数をクリア
			
			// ライフ減らす
			if ( life > 0 ) {
				life -= hit.damage;
				if ( life < 0 ) life = 0;
				
				mutekiTime = hit.mutekiTime;
			}
			// 死亡
			if ( life == 0 ) {
				
				// 誰死亡？
				if ( this is Enemy3 ) {
					//				毒の沼になる
					if ( currentLabel != "sp1" ) {
						switchAction("sp1");
						weigh = 100;
					}
				}
				else {
					seKO.play();
					// 				消滅フラグ
					switchAction("dead");
				}
				
				// 経験値加算
				if ( attacker is Player ) {
					Unit(attacker).skillEX++;
					if ( Unit(attacker).skillEX > 5 * Unit(attacker).skillLV) {
						Unit(attacker).skillLV++;
						Unit(attacker).skillEX = 0;
					}
				}
				
				// お金を撒く
				if ( attacker == null ) {
					Money.sprinkle(money,this,0);
				}
				Money.sprinkle(money,this,Math2.getAngle(attacker.x, attacker.y, this.x, this.y));
				
			}
			else {
				// スマッシュヒットの場合はダメージアクションへ移行
				if ( hit.smash ) {
					if ( (this is Frend2) ) {
						if ( this.currentLabel != "light" ) switchAction("damage");
					}
					else {
						switchAction("damage");
					}
				}
			}
		}




		public function switchAction(frameLabel:String = ""):void
		{
//			trace( [ "p:sw", currentFrame, dispMC.currentFrame] );
			if ( currentLabel == frameLabel ) return;

			//// ユニットのアクション制御
			if ( frameLabel != "" ) 
				gotoAndStop(frameLabel);
			else {
				if ( skillLV > 0 ) 
					nextFrame();
//					gotoAndStop( Math.min( skillLV+2, currentFrame+1 ) );
				else 
					nextFrame();
			}
		
			if ( frameLabel == "sp1" ) {
				deadfg = true;
				// トラップへ移行
				parent.removeChild(this);
				GameField.trapField.addChild(this);
			}
			if ( frameLabel == "dead" ) {
				deadfg = true;
				// 深度入れ替え
				parent.removeChild(this);
				GameField.deadUnitField.addChild(this);
			}
			
			dispMC = MovieClip(getChildAt(0));
			dispMC.play();
			
		}
		
		function animControl():void
		{
			
			var dispMC = MovieClip(getChildAt(0));
			var m:Motion = motionHolder[currentFrame-1];

			if ( m.name == "damage" ) {
				if ( dispMC.currentFrame == dispMC.totalFrames ) dispMC.stop();
				
				hit.koutyokuTime--;
				if ( hit.koutyokuTime == 0 ) {
					gotoAndStop( m.endJump );
				}
				return;
			}
			
			if ( dispMC.currentFrame == dispMC.totalFrames ) {
				
				switch ( m.endJump ) {
					// ループ
					case Motion.ENDJUMP_LOOP:	break;
					// 一回再生
					case Motion.ENDJUMP_STOP:	dispMC.stop();	break;
					// ジャンプ
					default: gotoAndStop(m.endJump);	break;
				}
				
				if ( m.name == "dead" ) deletefg = true;
				
				
			}
		}
		
	}
}
