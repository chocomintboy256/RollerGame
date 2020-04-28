package rollerGame.console 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import rollerGame.unit.Unit;

	public class LifeGauge extends MovieClip
	{
		public var bar:MovieClip;
		public var target:Unit;
		public function LifeGauge(tar:Unit)
		{
			target = tar;

		}
		public function action():void 
		{
			// iti
			x = target.x;
			y = target.y - 40;
			
			// life
			var s = target.life / target.lifeMax;
			if ( s == 0 ) {
				bar.visible = false;
			}
			else {
				bar.visible = true;
				bar.scaleX = s;
			}
			
			if ( target.life == 0 ) {
				visible = false;
			}
		}
		
		public function del():void 
		{
			
		}
	}

}