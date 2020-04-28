package  {
	import com.flashdynamix.motion.TweensyTimeline;
	import flash.display.MovieClip;
	import flash.events.Event;
	import rollerGame.util.FPS;
	
	import rollerGame.env.TitleSence;
	import rollerGame.env.EntranceSence;
	import rollerGame.env.BattleSence;
	import rollerGame.env.TownSence;
	import rollerGame.util.StageUtil;
	import com.flashdynamix.motion.Tweensy;
	
	public class Main extends MovieClip{
		public var unitNo:Number = 0;
		
		public var fps:FPS;
		public var sUtil:StageUtil;
		public var titleSence:TitleSence;
		public var entranceSence:EntranceSence;
		public var battleSence:BattleSence;
		public var townSence:TownSence;
		
		public function Main() {
			sUtil = new StageUtil(stage);
			fps = new FPS();
			addChild(fps);
			
			titleInit();
		}
		public function titleInit():void 
		{
			titleSence = new TitleSence();
			titleSence.addEventListener("SenceEnd",comp);
			function comp(event:Event):void 
			{
				removeChild(titleSence);
				entranceInit();
				titleSence = null;
			}
			addChild(titleSence);
		}
		
		public function entranceInit():void 
		{
			entranceSence = new EntranceSence();
			entranceSence.addEventListener("SenceEnd",comp);
			function comp(event:Event):void 
			{
				unitNo = entranceSence.selectUnitNo;
				removeChild(entranceSence);
				battleInit();
				entranceSence = null;
			}
			addChild(entranceSence);
		}
		
		public function battleInit():void 
		{
			// バトル初期化
			battleSence = new BattleSence();
			battleSence.addEventListener("SenceEnd",comp);
			function comp(event:Event):void 
			{
//				unitNo = battleSence.selectUnit;
				removeChild(battleSence);
				townInit();
				battleSence = null;
			}
			battleSence.alpha = 0;
			var tt:TweensyTimeline = Tweensy.to( battleSence, { alpha:1 } );
			tt.onComplete = function():void {	battleSence.init(unitNo); }
			addChild( battleSence );
		}
		
		public function townInit():void 
		{
			// タウン初期化
			townSence = new TownSence();
			townSence.addEventListener("SenceEnd",comp);
			function comp(event:Event):void 
			{
				removeChild(townSence);
				battleInit();
				townSence = null;
			}
			townSence.alpha = 0;
			var tt:TweensyTimeline = Tweensy.to( townSence, { alpha:1 } );
			tt.onComplete = function():void {	townSence.init(); }
			addChild( townSence );
		}		
	}
}


