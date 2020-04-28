package rollerGame.env {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import rollerGame.util.StageEffectShock;
	import rollerGame.util.StageEffectZoom;

	import flash.events.Event;
	
	public class GameField extends MovieClip {
		public var stageWidth:Number;
		public var stageHeight:Number;
		public static var instance:GameField;
		public static var trapField:MovieClip;
		public static var deadUnitField:MovieClip;
		public static var unitField:MovieClip;
		public static var playerField:MovieClip;
		public static var moneyField:MovieClip;
		public static var shotField:MovieClip;
		public static var gaugeField:MovieClip;
		public static var battleSence:MovieClip;
		public static var insScrEffShock:StageEffectShock;
		public static var insScrEffZoom:StageEffectZoom;
		
		public function GameField() {
			instance = this;
			trapField = new MovieClip();
			deadUnitField = new MovieClip();
			unitField = new MovieClip();
			playerField = new MovieClip();
			moneyField = new MovieClip();
			shotField = new MovieClip();
			gaugeField = new MovieClip();
		}
		public function init() {
			battleSence = parent as MovieClip;
			insScrEffShock = new StageEffectShock(battleSence);
			insScrEffZoom = new StageEffectZoom(battleSence);
			
			stageWidth = stage.stageWidth * 2;
			stageHeight = stage.stageHeight * 2;
			
			scaleX = 0.5;
			scaleY = 0.5;
			
			addChild(trapField);
			addChild(moneyField);
			addChild(deadUnitField);
			addChild(unitField);
			addChild(playerField);
			addChild(shotField);
			addChild(gaugeField);
		}
	}
}
