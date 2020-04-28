package rollerGame.env 
{
	import com.flashdynamix.motion.TweensyTimeline;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import com.flashdynamix.motion.Tweensy;
	import com.flashdynamix.motion.TweensyGroup;
	
	public class TitleSence extends MovieClip
	{
		public var btn_play:TextField;
		public var tg:TweensyGroup = new TweensyGroup();
		
		public function TitleSence()
		{
			btn_play.addEventListener(MouseEvent.CLICK, mouse_handler );
		}
		public function init(unitNo:Number):void 
		{			
		}
		
		private function mouse_handler(e:MouseEvent):void 
		{
			tg.colorTo( this, 0x000000 ).onComplete = function ():void 
			{
				dispatchEvent(new Event("SenceEnd"));
			}
		}
	}

}