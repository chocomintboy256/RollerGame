package rollerGame.data 
{

	public class Motion
	{
		public var name:String;
		public var endJump:Number;
		public var deadJump:Number;
		
		public static const ENDJUMP_LOOP:Number = -1;
		public static const ENDJUMP_STOP:Number = 0;
		public static const ENDJUMP_DEFAULT:Number = 2;
		
		public static const DEADJUMP_DEFAULT:Number = -1;
		public function Motion(_name:String,_endJump:Number = ENDJUMP_DEFAULT, _deadJump:Number = 3 ) 
		{
			name = _name;
			endJump = _endJump;
			deadJump = _deadJump;
		}
		
	}

}