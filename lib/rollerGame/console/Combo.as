package rollerGame.console 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.EventDispatcher;
	
	public class Combo extends MovieClip
	{
		public static const TIMER_END:String = "TIMER_END";
		private var tim:Timer = new Timer(1500, 1);
		private var alphaFg:Boolean = false;
/*--------------- public function--------------*/
		public function Combo() 
		{
			reset();
			
			addEventListener(Event.ENTER_FRAME, eh);
			tim.addEventListener(TimerEvent.TIMER_COMPLETE, timComp );
		}
		public function setHit(n:Number):void 
		{
			if ( n == 1 ) {
				tim.start();
				return;
			}
			setNum( hit, n.toString() );
		}
		public function setSmash(n:Number):void 
		{
			setNum( smash, n.toString() );
		}
		
/*--------------- private function --------------*/
		private function reset():void 
		{
			hit.visible = false;
			hit.gotoAndStop(1);
			for ( var i = 1; i <= hit.num.numChildren; i++ ) {
				hit.num["n" + i].stop();
			}
			smash.visible = false;
			smash.gotoAndStop(1);
			for ( i = 1; i <= smash.num.numChildren; i++ ) {
				smash.num["n" + i].stop();
			}
		}
		private function eh(event:Event):void 
		{
			if ( hit.currentFrame == hit.totalFrames ) hit.stop();
			if ( smash.currentFrame == smash.totalFrames ) smash.stop();
			
			if ( alphaFg ) {
				alpha += -alpha * 0.3;
				if ( alpha <= 0.01 ) {
					alpha = 0;
					alphaFg = false;
					visible = false;
					
					reset();
					dispatchEvent(new Event(TIMER_END));
				}
			}
		}
		private function timComp(event:TimerEvent):void 
		{
			alphaFg = true;
		}
		
		private function setNum( target:MovieClip, ns:String):void 
		{
			for ( var i = 1; i <= ns.length; i++ ) {
				var c:Number = Number(ns.charAt(ns.length - i));
				if ( c == 0 ) c = 10;
				
				MovieClip(target.num["n" + String(i)]).visible = true;
				MovieClip(target.num["n" + String(i)]).gotoAndStop(c);
			}
			for ( ; i <= target.num.numChildren; i++ ) {
				MovieClip(target.num["n" + String(i)]).stop();
				MovieClip(target.num["n" + String(i)]).visible = false;
			}
			
			// Hit数やSmash数の表示。ただし 1Hit は表示しない
			target.visible = true;
			if ( target == hit ) {
				if ( target.currentFrame == 1 ) target.play();
			}
			else target.play();
			
			alpha = 100;
			alphaFg = false;
			visible = true;
			
			tim.reset();
			tim.start();
		}
		
	}

}