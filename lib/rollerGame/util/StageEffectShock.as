package rollerGame.util 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;

	public class StageEffectShock extends Sprite
	{
		public static var ins:StageEffectShock;
		var screen:MovieClip;
		var init_x:Number;
		var init_y:Number;
		
		public function StageEffectShock(screen:MovieClip) 
		{
			ins = this;
			this.screen = screen;
			init_x = screen.x;
			init_y = screen.y;
		}
		
		
		private var rate:Number = 2;
		private var now:Number = 0;
		private var data:Array = [
			new Point(-1,-1),
			new Point(1,0),
			new Point(0,1),
			new Point(-1,0),
			new Point(1,-1),
			new Point(-1,1),
			new Point(1,1)
		];
		public function shock():void 
		{
			play();
		}
		
		public function play():void 
		{
			if ( hasEventListener(Event.ENTER_FRAME) ) {
				rePlay();
			}
			else {
				addEventListener(Event.ENTER_FRAME, playing);
			}
		}
		public function stop():void 
		{
			removeEventListener(Event.ENTER_FRAME, playing );
		}
		public function end():void 
		{
			now = 0;
			removeEventListener(Event.ENTER_FRAME, playing );
		}
		public function rePlay():void 
		{
			now = 0;
			addEventListener(Event.ENTER_FRAME, playing);
		}
		
		public function playing(event:Event):void 
		{
			now++;
			if ( now == data.length ) end();
			screen.x = screen.x + (data[now].x * rate) - (data[(now==0?0:now-1)].x * rate);
			screen.y = screen.y + (data[now].y * rate) - (data[(now==0?0:now-1)].y * rate);
		}
	}

}
