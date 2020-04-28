package rollerGame.util
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import rollerGame.util.StageUtil;
	
	public class Input
	{
		public static const TRG_UP:int = 1;
		public static const TRG_DOWN:int = 2;
		public static const TRG_NEWTRAL:int = 0;
		
		public static var mouseDown:Boolean = false;	// 押されている状態
		public static var mouseTrg:int = TRG_NEWTRAL;	// 押された状態
		public static var mouseHold:Boolean = false;	// 維持状態
		
		private static var holdTimer:uint = 0;
		private static var holdTimerMax:uint = 59;
		public function Input() 
		{			
			// ステージのマウスが押された場合にフラグを立てる
			StageUtil.stage.addEventListener(MouseEvent.MOUSE_DOWN, md );
			function md(e:Event):void 
			{
				mouseDown = true;
				mouseTrg = TRG_DOWN;
				holdTimer = 0;
			}
			StageUtil.stage.addEventListener(MouseEvent.MOUSE_UP, mu );
			function mu(e:Event):void 
			{
				mouseDown = false;
				mouseTrg = TRG_UP;
				holdTimer = 0;
			}
		}
		
		// メインループの最後でトリガをクリアすること
		public static function trgClear() {
			holdTimer++;
			if ( holdTimer > holdTimerMax ) {
				holdTimer = holdTimerMax;
				mouseHold = true;
			}
			else mouseHold = false;
			
			mouseTrg = TRG_NEWTRAL;
			
		}
		
	}

}