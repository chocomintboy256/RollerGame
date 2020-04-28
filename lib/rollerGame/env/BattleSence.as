package rollerGame.env 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import rollerGame.env.UnitMgr;
	
	import rollerGame.env.GameField;
	import rollerGame.env.GameMgr;
	import rollerGame.util.Input;
	
	public class BattleSence extends MovieClip
	{
		public var gameField:GameField;
		public var gameMgr:GameMgr;
		public var unitMgr:UnitMgr;
		public var topo:MovieClip;
		public var inp:Input;
		public var console:MovieClip;
		public var rootData:RootData;

		private var stageSize:Point = new Point(550, 400);
		private var stageLimitRect:Rectangle = new Rectangle(0, 0, 550 - stageSize.x, 400*2 - stageSize.y);
		
		public function BattleSence()
		{
			topo.visible = false;
			addEventListener(Event.ENTER_FRAME, scroll);
		}
		public function init(unitNo:Number):void 
		{			
			gameField = new GameField();
			addChild(gameField);
			gameField.init();
			swapChildren(gameField, console);

			gameMgr = new GameMgr();
			unitMgr = new UnitMgr();
			gameMgr.init(unitNo);

			inp = new Input();
			
/*				var imputSheet:InputSheet = new InputSheet;
			addChild(imputSheet);
			*/
		}
		
		function scroll(event:Event):void 
		{
			if ( GameMgr.player == null ) return;
			
			var p:Point = GameMgr.player.parent.localToGlobal( new Point( GameMgr.player.x, GameMgr.player.y ) );
			p = globalToLocal(p);
						
			x = -(p.x - stageSize.x / 2);
			y = -(p.y - stageSize.y / 2);
			
			if ( x < -stageLimitRect.width ) x = -stageLimitRect.width;		// 左クリッピング
			if ( x > -stageLimitRect.x ) x = -stageLimitRect.x;				// 右クリッピング
			if ( y < -stageLimitRect.height ) y = -stageLimitRect.height;	// 上クリッピング
			if ( y > -stageLimitRect.y ) y = -stageLimitRect.y;				// 下クリッピング
			
			console.x = x;
			console.y = 336.05 - y;
		}
	}

}