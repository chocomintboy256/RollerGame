package rollerGame.unit 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class Player2 extends MovieClip
	{
		var plist:Array = new Array();
		var lockU:Unit;
		public function Player2() 
		{
			addEventListener(Event.ENTER_FRAME, ef);
			function ef(event:Event):void 
			{
				
			}
		}
		public function regist(u:Unit):void 
		{
			plist.push(u);
			u.addEventListener(MouseEvent.MOUSE_OVER, mo);
		}
		public function mo(event:Event):void 
		{
			lockU = event.target;
		}
	}

}