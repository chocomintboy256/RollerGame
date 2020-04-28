package rollerGame.console 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author 
	 */
	public class Console extends MovieClip
	{
		public static var instance:Console;
		public var combo:Combo;
		public function Console() 
		{
			instance = this;
//			visible = false;
			combo = new Combo();
			addChild( combo );
			combo.x = 540;
			combo.y = -320;
		}
		
	}

}