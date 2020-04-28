package rollerGame.util 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class FPS extends MovieClip
	{
		public static var text_field = new TextField();
		public function FPS() 
		{
			addEventListener(Event.ADDED_TO_STAGE, setFPSGauge);
		}
		private function setFPSGauge(event:Event):void 
		{
			// テキストフィールド
			text_field.background = true;
			text_field.width = 60;
			text_field.height = 18;
			text_field.x = stage.stageWidth - text_field.width;
			stage.addChild (text_field);

			var update_time = 500;       // 表示が変わる時間（ミリ秒）
			var draw_count = 0;          // 描画カウント
			var old_timer = getTimer();  // 時間待避

			trace(stage);
			stage.addEventListener(Event.ENTER_FRAME ,function(){
			draw_count += 1;
				if (getTimer()-old_timer >= update_time) {
					// 少数第1位まで表示
					var fps = draw_count * 1000 / (getTimer() - old_timer);
					fps = Math.floor(fps * 10) / 10;  

					text_field.text = fps + ' / ' + stage.frameRate;

					old_timer = getTimer();
					draw_count = 0;
				}
			});
		}
		
	}

}