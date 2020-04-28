package rollerGame.env
{
	import com.flashdynamix.motion.TweensyGroup;
	import com.flashdynamix.motion.TweensyTimeline;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	// 
	// 
	// シーン終了の段取り:
	//	new Event("SenceEnd")がdispatchされます
	//  扱う側は addEventListener( "SenceEnd", イベントハンドラ ); してください。
	public class TownSence extends MovieClip
	{
		public var btn_next:MovieClip;
		public var tg:TweensyGroup = new TweensyGroup();
		public var tt:TweensyTimeline = new TweensyTimeline();
		
		public function TownSence() 
		{
			btn_next.addEventListener(MouseEvent.MOUSE_OVER,mouse_handler);
			btn_next.addEventListener(MouseEvent.MOUSE_OUT,mouse_handler);
			btn_next.addEventListener(MouseEvent.CLICK,mouse_handler);
		}
		public function init():void 
		{
			
		}
		private function mouse_handler(e:MouseEvent):void 
		{
			switch (e.type) 
			{
				case MouseEvent.MOUSE_OVER:	tg.remove(tt); tt = tg.brightnessTo( e.currentTarget as MovieClip, 0.5, 1 / 8 ); break;
				case MouseEvent.MOUSE_OUT:	tg.remove(tt); tt = tg.brightnessTo( e.currentTarget as MovieClip, 0, 1 / 2 ); break;
				case MouseEvent.CLICK:
					tg = new TweensyGroup();
					tg.colorTo(this, 0x000000, 0.5);
					tg.onComplete = function():void 
					{
						dispatchEvent(new Event("SenceEnd"));
						tg.onComplete = null;
					}
					break;
			}
		}
	}

}