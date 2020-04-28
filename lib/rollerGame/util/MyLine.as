package rollerGame.util {
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class MyLine extends MovieClip {

		public var base:MovieClip;
		
		public function MyLine() {}
		public function get left():Point { 
			return localToGlobal(new Point(base.x, base.y + base.height/2));
		}
		public function get right():Point { 
			return localToGlobal(new Point(base.x + base.width, base.y + base.height/2));
		}

		public function getLineData():Object
		{
			return { left:left,	right:right }
		}
		
		public function getRectPoint4() {
			return {
				lt:localToGlobal(new Point(base.x, base.y)),
				rt:localToGlobal(new Point(base.x + base.width, base.y)),
				lb:localToGlobal(new Point(base.x, base.y + base.height)),
				rb:localToGlobal(new Point(base.x + base.width, base.y + base.height))
			}
		}

	}
	
}
