package rollerGame.util 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;

	public class StageEffectZoom extends Sprite
	{
		public static var ins:StageEffectZoom;
		var screen:MovieClip;
		var init_scale:Number;
		var sequenceFunc:Function;
		
		public function StageEffectZoom(screen:MovieClip) 
		{
			ins = this;
			this.screen = screen;
			init_scale = screen.scaleX;
			initPos = new Point( screen.x, screen.y );
		}
		
		
		private var timer:Number = 0;
		private var waitTime:Number;
		private var scale:Number = 2;
		private var initPos:Point;
		private var targetPos:Point;

		public function zoom():void 
		{
//			start();
		}
		
		//---- コマンドエントランス
		public function start(m:MovieClip, waitTime:Number = 60):void 
		{
			targetPos = m.parent.localToGlobal( new Point(m.x, m.y) );
			targetPos = screen.globalToLocal( targetPos );
			targetPos.x = initPos.x - targetPos.x;
			targetPos.y = initPos.y - targetPos.y;
			
			trace( initPos, targetPos );
			this.waitTime = waitTime;
			zoomIn();
		}
		public function stop():void 
		{
			if ( sequenceFunc == null ) return;
			removeEventListener(Event.ENTER_FRAME, sequenceFunc );
		}
		public function reStart():void 
		{
			addEventListener(Event.ENTER_FRAME, sequenceFunc );
		}
		public function rePlay(m:MovieClip):void 
		{
			end();
			start(m);
		}
		
		//---- シーケンシャル制御
		private function zoomIn():void 
		{
			if ( hasEventListener(Event.ENTER_FRAME) ) {
				removeEventListener(Event.ENTER_FRAME, sequenceFunc);
			}
			addEventListener(Event.ENTER_FRAME, zoomingIn);
			sequenceFunc = zoomingIn;
		}
		private function wait():void 
		{
			removeEventListener(Event.ENTER_FRAME, sequenceFunc );
			addEventListener(Event.ENTER_FRAME, waiting );
			sequenceFunc = waiting;
		}
		public function zoomOut():void 
		{
			removeEventListener(Event.ENTER_FRAME, sequenceFunc );
			addEventListener(Event.ENTER_FRAME, zoomingOut );
			sequenceFunc = zoomingOut;
		}
		private function end():void 
		{
			screen.scaleX = screen.scaleY = init_scale;
			screen.x = initPos.x;
			screen.y = initPos.y;
			if ( sequenceFunc != null ) {
				removeEventListener(Event.ENTER_FRAME, sequenceFunc );
				sequenceFunc = null;
			}
			timer = 0;
		}
		
		//---- モーション処理
		private function waiting(event:Event):void 
		{
			if ( timer++ >= waitTime ) zoomOut();
		}
		private function zoomingIn(event:Event):void 
		{
			screen.x += (targetPos.x-screen.x) * 0.125;
			screen.y += (targetPos.y-screen.y) * 0.125;
			screen.scaleX += (scale-screen.scaleX) * 0.125;
			screen.scaleY += (scale-screen.scaleY) * 0.125;
			if ( Math.abs( scale - screen.scaleX ) < 0.01
				&& Math.abs( targetPos.x - screen.x ) < 1
				&& Math.abs( targetPos.y - screen.y ) < 1
			) wait();
			
		}
		private function zoomingOut(event:Event):void 
		{
			screen.x += (initPos.x-screen.x) * 0.125;
			screen.y += (initPos.y-screen.y) * 0.125;
			screen.scaleX += (init_scale-screen.scaleX) * 0.125;
			screen.scaleY += (init_scale-screen.scaleY) * 0.125;
			if ( Math.abs( init_scale - screen.scaleX ) < 0.01
				&& Math.abs( initPos.x - screen.x ) < 1
				&& Math.abs( initPos.y - screen.y ) < 1
			) end();
		}
	}
}
