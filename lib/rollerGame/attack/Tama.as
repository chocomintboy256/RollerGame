package rollerGame.attack {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import flash.events.Event;
	
	import rollerGame.util.Math2;
	import rollerGame.env.GameMgr;
	
	import rollerGame.unit.Unit;
	
	public dynamic class Tama extends Unit {
		var ang:Number = 0;
		var spd:Number = 15;
		var offsetX:Number = -10;
		var offsetY:Number = -10;
		var time:Number = 0;
		var timeMax:Number = 60*5;
			
		public function Tama() {
			addEventListener( Event.ENTER_FRAME, en );
		}
		function en(e:Event):void {
			
			// 移動量
			var mx:Number, my:Number;
			mx = spd * Math.cos(ang * Math2.CRAG);
			my = spd * Math.sin(ang * Math2.CRAG);
			
			// 移動
			var move_ret:Boolean = GameMgr.topo.clipRay(this, x + mx, y + my );
			
			//――― 消滅判定 ―――
			var delFg:Boolean = false;
			// （消滅判定：フィールド当り）
			if ( move_ret ) delFg = true;
			// (消滅判定:画面外)
			else if ( x < 0 - offsetX || x > GameMgr.field.stageWidth + offsetX ) delFg = true;
			else if ( y < 0 - offsetY || y > GameMgr.field.stageHeight + offsetY ) delFg = true;
			// (消滅判定:タイマー)
			else if ( time++ >= timeMax ) delFg = true;
			
			if ( delFg ) del();
		}
		public function seting(a:Number, s:Number) {
			ang = a;
			spd = s;
		}
		public function del() {
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, en );
			delete this;
		}
	}
}
