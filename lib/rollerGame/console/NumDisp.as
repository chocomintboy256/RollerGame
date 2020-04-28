package rollerGame.console 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.events.EventDispatcher;
	import com.flashdynamix.motion.Tweensy;
	import com.flashdynamix.motion.TweensyGroup;
	import fl.motion.easing.Sine;
	
	public class NumDisp extends MovieClip
	{
/*--------------- public function--------------*/
		public function NumDisp(num:Number) 
		{
			var tf:TextField = new TextField();
			
			tf.embedFonts = true;
			tf.setTextFormat(new TextFormat());
			tf.text = num;
			
			// アニメーション
			var tg:TweensyGroup = new TweensyGroup();
			tg.fromTo( tf, { alpha:0 }, { alpha:100 } );
			tg.fromTo( tf, { x:-30 }, { x:0 }, 1 );
			tg.filterTo( tf, new BlurFilter(0,0), { blurX:10, blurY:10 }, 1, Sine.easeOut);
			
			addChild(tf);
		}
		
/*--------------- private function --------------*/
		private function reset():void 
		{
		}
		private function eh(event:Event):void 
		{
		}
		private function timComp(event:TimerEvent):void 
		{
		}
		
		private function setNum( target:MovieClip, ns:String):void 
		{
		}
		
	}

}