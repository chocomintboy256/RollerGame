package rollerGame.env 
{
	import com.flashdynamix.motion.TweensyGroup;
	import com.flashdynamix.motion.extras.ColorMatrix;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.flashdynamix.motion.Tweensy;
	import fl.motion.easing.*;
	
	import flash.filters.ColorMatrixFilter;	
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * 
	 * ■ メニュー仕様
	 * パネルロールオーバーで選択（明るく）
	 * パネルロールアウトで選択解除（暗く）
	 * パネルクリックで決定（側が光る）
	 * ボタンクリックで終了
	 */
	public class EntranceSence extends MovieClip
	{
		public var selectUnit:MovieClip = null;
		public var selectUnitNo:Number = -1;
		private var tg:TweensyGroup = new TweensyGroup();
		private var g_filt:GlowFilter = new GlowFilter(0xFFFFFF, 1, 0, 0, 0);
		private var c_filt:ColorMatrixFilter = new ColorMatrixFilter();
		private var cMat_normal:ColorMatrix = new ColorMatrix(0, 1, 1, 0);
		private var cMat_tintDown:ColorMatrix = new ColorMatrix(-0.2, 1, 1, 0);
		private var cMat_tintUp:ColorMatrix = new ColorMatrix(0.2, 1, 1, 0);
		private var gMat_normal:Object = { blurX:0, blurY:0, strength:0 };
		private var gMat_lighting:Object = { blurX:10, blurY:10, strength:3 };
		
		private var units:Array = new Array();
		public function EntranceSence() 
		{
			// いまいるユニットを一覧に加える
			for ( var i = 0; unit["unit" + (i + 1)] != undefined; i++ )
				units.push( unit["unit"+(i+1)] );
			
			for each ( var u in units ) 
			{
				u.id = units.indexOf(u);
				u.g_filt = new GlowFilter(0xFFFFFF, 1, 0, 0, 0);
				u.c_filt = new ColorMatrixFilter();
				u.addEventListener(MouseEvent.ROLL_OVER, panel_over);
				u.addEventListener(MouseEvent.ROLL_OUT, panel_out);
				u.addEventListener(MouseEvent.CLICK, panel_click);
				tg.to(u.c_filt, cMat_tintDown, -1, null, 0, u);
			}
			
			btn.addEventListener(MouseEvent.MOUSE_OVER,btn_over);
			btn.addEventListener(MouseEvent.MOUSE_OUT,btn_out);
			btn.addEventListener(MouseEvent.CLICK,btn_click);
		}
		private function panel_over(event:MouseEvent):void 
		{
			if ( selectUnit == event.target ) return;
			tg.to(event.target.c_filt, cMat_normal, 0.125, Linear.easeIn, 0, event.target);
		}
		private function panel_out(event:MouseEvent):void 
		{
			if ( selectUnit == event.target ) return;
			tg.to(event.target.c_filt, cMat_tintDown, 0.125, Linear.easeIn, 0, event.target);
		}
		private function panel_click(event:MouseEvent):void 
		{
			if ( selectUnit == event.target ) return;
			if ( selectUnit != null ) {
				tg.filterTo(selectUnit, selectUnit.g_filt, gMat_normal, 0.125, Linear.easeIn);
				tg.filterTo(selectUnit, selectUnit.c_filt, cMat_tintDown, 0.125, Linear.easeIn);
			}
			tg.filterTo(event.target as MovieClip, event.target.g_filt, gMat_lighting, 0.125, Linear.easeIn);
			
			selectUnit = event.target as MovieClip;
		}
		
		private function btn_over(event:MouseEvent):void 
		{
			tg.to(c_filt, cMat_tintUp, 0.125, Linear.easeIn, 0, btn );
		}
		private function btn_out(event:MouseEvent):void 
		{
			tg.to(c_filt, cMat_normal, 0.125, Linear.easeIn, 0, btn );
		}
		private function btn_click(event:MouseEvent):void 
		{
			Tweensy.to(this, { alpha:0 }, 0.5, null, 0, null, comp );
			function comp():void 
			{
				if ( selectUnit == null ) selectUnitNo = 1;
				else selectUnitNo = selectUnit.id;
				
				dispatchEvent(new Event("SenceEnd"));
			}
		}
	}

}