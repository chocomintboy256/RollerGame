package rollerGame.env
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	public class HyoukaForm extends MovieClip
	{
		public var title:TextField;
		public var msg:TextField;
		public var txt_next:TextField;
		
		public var hyoukatemp:String = "撃破数:\n" +
										"スマッシュ数:\n" +
										"得点:\n";

		public var tim:Timer = new Timer(1000/2,3);
		
		public function HyoukaForm() 
		{
			title.visible = true;
			msg.text = "";
			txt_next.visible = false;
			
			tim.addEventListener(TimerEvent.TIMER, tm_handler);	
			tim.addEventListener(TimerEvent.TIMER_COMPLETE, tmc_handler);
			tim.start();
			
			txt_next.addEventListener(MouseEvent.CLICK, mouse_handler);
		}
		public function tm_handler(e:TimerEvent):void 
		{
			var c = 0;
			for ( var i = 0; i < tim.repeatCount; i++ ) 
				c = hyoukatemp.indexOf("\n", c);
			
			msg.text = hyoukatemp.substring(0, c);
		}
		public function tmc_handler(e:TimerEvent):void 
		{
			txt_next.visible = true;
		}		
		private function mouse_handler(e:MouseEvent):void 
		{
			dispatchEvent( new Event("SenceEnd") );
		}
	}

}