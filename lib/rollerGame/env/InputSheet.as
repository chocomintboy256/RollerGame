package rollerGame.env {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public dynamic class InputSheet extends Sprite {
		public static var modeFg:int;
		public var m:ActMenu;
		
		public function InputSheet() {
			modeFg = 0;
			
			addEventListener( MouseEvent.MOUSE_UP, mu );
			function mu(e:MouseEvent):void {
				delMenu();
			}
			addEventListener( MouseEvent.MOUSE_DOWN, md );
			function md(e:MouseEvent):void {
				getMenu(stage.mouseX, stage.mouseY);
				
				m.p1.addEventListener( MouseEvent.ROLL_OVER, mu1 );
				function mu1(e:MouseEvent):void {
					modeFg = 0;
				}
				m.p2.addEventListener( MouseEvent.ROLL_OVER, mu2 );
				function mu2(e:MouseEvent):void {
					modeFg = 1;
				}
				m.p3.addEventListener( MouseEvent.ROLL_OVER, mu3 );
				function mu3(e:MouseEvent):void {
					modeFg = 2;
				}
				m.p4.addEventListener( MouseEvent.ROLL_OVER, mu4 );
				function mu4(e:MouseEvent):void {
					modeFg = 3;
				}
				m.p5.addEventListener( MouseEvent.ROLL_OVER, mu5 );
				function mu5(e:MouseEvent):void {
					modeFg = 4;
				}
			}
			
		}
		
		public function getMenu(x:Number,y:Number):void {
			m = new ActMenu;
			addChild(m);
			m.x = x;
			m.y = y;
		}
		public function delMenu():void{
			removeChild(m);
			m = null;
		}
	}
}
