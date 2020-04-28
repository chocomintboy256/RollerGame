package rollerGame.data 
{
	public class ActStateData
	{
		public static const ACT_ALERT:uint = 1;
		public static const ACT_RUN:uint = 2;
		public static const ACT_LIGHT:uint = 3;
		public static const ACT_MIDDLE:uint = 4;
		public static const ACT_HEAVY:uint = 5;
		public static const ACT_SPECIAL1:uint = 6;
		public static const ACT_SPECIAL2:uint = 7;
		public static const ACT_SPECIAL3:uint = 8;
		
		public var state:uint;
		public var loopFg:Boolean;
		
		public function ActStateData(st:uint, lf:Boolean = false) 
		{
			state = st;
			loopFg = lf;
		}
		
	}

}