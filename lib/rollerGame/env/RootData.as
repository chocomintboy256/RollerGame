package rollerGame.env
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class RootData extends MovieClip
	{
		public var stageNoText:TextField;
		public var stageNo:Number = 0;
		
		public static const connect:Array = [
			[ 
				["A1", "A2", "A3", "A4", "A5", "A6", "C1","End"]
			]
		];
		public function RootData() 
		{
			stageNo = Number( stageNoText.text.replace("stage", "") );
		}
		
	}

}