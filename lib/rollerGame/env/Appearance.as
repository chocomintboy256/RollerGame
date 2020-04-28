package rollerGame.env {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Timer;
	
	import flash.events.Event;	
	import rollerGame.env.UnitMgr;
	import rollerGame.unit.Unit;
	import rollerGame.unit.Frend1;
	import rollerGame.unit.Frend2;
	import rollerGame.unit.Enemy1;
	import rollerGame.unit.Enemy2;
	import rollerGame.unit.Enemy3;
	import rollerGame.unit.Enemy4;
	import rollerGame.unit.Enemy5;
	
	public class Appearance {

		private var tim:Timer = new Timer(500, 1);
		private var setnum:Number = 120;
		
		private var setListHolder:Array;
		var holderCount:Number = 0;
		
		public function Appearance() {
//return;/*テスト用*/
			
			setListHolder = [
				[ Enemy1 ],
				[ Enemy1, Enemy1, Enemy1, Enemy1 ],
				[ Enemy1, Enemy1, Enemy1, Enemy1, Enemy1 ],
				[ Enemy2, Enemy2 ],	
				[ Frend2 ],	
				[ Enemy1, Enemy1, Enemy1, Enemy2, Enemy2 ],
				[ Enemy1, Enemy1, Enemy1, Enemy1, Enemy1, Enemy1, Enemy1, Enemy1 ],
				[ Enemy2, Enemy2, Enemy2, Enemy2, Enemy2 ],
				[ Enemy1, Enemy1, Enemy1, Enemy1, Enemy1, Enemy2, Enemy2, Enemy2 ],
				[ Enemy1, Enemy1, Enemy1, Enemy1, Enemy1, Enemy2, Enemy2, Enemy2 ]
			];
			
			tim.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeConp );
		}

		public function proc():void {
			
			if ( GameMgr.enemy.length > 0 ) return;
			
			if ( !tim.running ) tim.start();
			
		}
		
		// 生成モード
		function onTimeConp(e:Event):void 
		{
			// 生成要素設定
			var cList:Array = getCreateList();
			function getCreateList():Array
			{
				if (setListHolder[holderCount] == "dummy" ) {
					var list:Array = new Array();
					for ( var i = 0; i < setnum; i++ ) list.push(Enemy1);
					return list;
				}
				else {
					return setListHolder[holderCount];
				}
			}
			
			// 生成
			for each ( var elem in cList ) create(elem);
			
			holderCount = ( holderCount + 1 == setListHolder.length ? 0 : holderCount + 1 );
		}
		
		public function create(cName:Object):void {
			
			var e:Unit = UnitMgr.create(getQualifiedClassName(cName));
			var ep:Point = null;
			for ( var i = 0; i < 10; i++ ) {
				e.x = Math.floor( Math.random() * GameMgr.field.stageWidth );
				e.y = Math.floor( Math.random() * GameMgr.field.stageHeight );
				
				ep = e.parent.localToGlobal( new Point(e.x,e.y) );
				ep = GameField.battleSence.globalToLocal(ep);
				if ( !GameField.battleSence.topo.hitTestPoint(ep.x, ep.y,true) ) break;
				ep = null;
			}
			if ( ep == null ) { e.x = 100; e.y = 200; }
			
			e.init();
			GameMgr.enemy.push( e );
		}
		
		public function delRegist():void {
			
			var count;
			var elem:Unit;
			for ( count = 0; count < GameMgr.enemy.length; ) 
			{
				elem = GameMgr.enemy[count];
				
				if ( elem.deletefg ) {
					UnitMgr.remove(elem);
					GameMgr.enemy.splice(count,1);
				}
				else if ( elem.deadfg && elem.currentLabel != "dead" ) {
					elem.deadfg = false;
					GameMgr.trap.push(elem);
					GameMgr.enemy.splice(count, 1);
				}
				else count++;
			}
			
			for ( count = 0; count < GameMgr.trap.length; ) 
			{
				elem = GameMgr.trap[count];
				
				if ( elem.deletefg ) {
					UnitMgr.remove(elem);
					GameMgr.trap.splice( count, 1 );
				}
				else if ( elem.deadfg && elem.currentLabel != "dead" ) {
					elem.deadfg = false;
					GameMgr.trap.push(elem);
					GameMgr.trap.splice( count, 1 );
				}
				else count++;
			}			
		
		}
	}
}
