package rollerGame.util {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import flash.events.Event;
	import flash.geom.Point;
	
	import rollerGame.env.GameMgr;
	
	public dynamic class Math2 {
		public static const CRAG:Number = Math.PI / 180;
		public static const CDEG:Number = 180 / Math.PI;
		
		public function Math2() {
		}
		
					/*
			// 円のクリップ処理 テストコード
			var p1 = new Player();
			var p2 = new Player();
			addChild(p1);
			addChild(p2);			
			addEventListener( Event.ENTER_FRAME, en2 );
			function en2(e:Event):void {
				p1.x = p1.parent.mouseX;
				p1.y = p1.parent.mouseY;

				
				var pt1 = new Point( p1.hitRange.x, p1.hitRange.y );
				pt1 = p1.hitRange.localToGlobal( pt1 );
				pt1 = GameMgr.field.globalToLocal( pt1 );
				var pt2 = new Point( p2.hitRange.x, p2.hitRange.y );
				pt2 = p2.hitRange.localToGlobal( pt2 );
				pt2 = GameMgr.field.globalToLocal( pt2 );
				
				var k = Math2.getRange(pt1.x, pt1.y, pt2.x, pt2.y );
				var l = p1.hitRange.width / 2 + p1.hitRange.width / 2;				
				
				if ( l >= k ) trace( [k, l] );
			}
			*/
			
		//
		// 四角形当たりテスト
		//
		public static function rectHitCheck(r:MovieClip, ehit:MovieClip) {
			var c:MovieClip;
			for (var i:int = 0; i < r.numChildren; i++)
			{
				c = MovieClip(r.getChildAt(i));
				if ( c.hitTestObject( ehit ) ) return true;
			}
			return false;
			
		}
		
		//
		// 円同士の当たりテスト
		//
		public static function roundHitCheck(r:MovieClip, ehit:MovieClip) {
			var c:MovieClip;
			var k:Number;
			var l:Number;
			
			var p1:Point;
			var p2:Point;
			var p1r:Number;
			var p2r:Number;
			
			p2 = new Point( ehit.x, ehit.y );
			p2 = ehit.parent.localToGlobal( p2 );
			p2 = GameMgr.field.globalToLocal( p2 );
			p2r = ehit.width / 2;
			
			for (var i:int = 0; i < r.numChildren; i++) 
			{
				c = MovieClip(r.getChildAt(i));
				
				p1 = new Point( c.x, c.y );
				p1 = c.parent.localToGlobal( p1 );
				p1 = GameMgr.field.globalToLocal( p1 );
				p1r = c.width / 2;
				
				k = Math.sqrt( Math.pow((p1.x - p2.x), 2) + Math.pow((p1.y - p2.y), 2) );
				l = p1r + p2r;
				
				if ( l >= k ) return true;
			}

			return false;
			
		}
		
		//
		// ２角度間の距離
		// 
		public static function getRoundRange(a:Number, b:Number):Number {
			var sa:Number;
			
			if ( a < 0 ) a += 360;
			if ( b < 0 ) b += 360;
			sa = b - a;
			if ( sa < -180 ) sa += 360;
			if ( sa > 180 ) sa -= 360;
			
			return sa;
		}
		
		//
		// ２点間の距離
		//
		public static function getRange(x0:Number,y0:Number,x1:Number,y1:Number):Number {
			var a:Number = x1-x0;
			var b:Number = y1-y0;
			return Math.sqrt(a*a+b*b);
		}
		
		//
		// ２点間の角度
		//
		public static function getAngle(x0:Number,y0:Number,x1:Number,y1:Number):Number {
			
			var w:Number = x1 - x0;
			var h:Number = y1 - y0;
			var rad:Number = Math.atan2(h, w);
			
			return rad * CDEG;
		}
		
		//
		// ２点間の角度（ラジアン角）
		//
		public static function getAngleRag(x0:Number,y0:Number,x1:Number,y1:Number):Number {
			
			var w:Number = x1 - x0;
			var h:Number = y1 - y0;
			var rad:Number = Math.atan2(h, w);
			
			return rad;
		}
		
		//
		// 度数でsin算出
		//
		public static function sin(deg:Number):Number {
			return Math.sin((deg)*CRAG);
		}
		//
		// 度数でcos算出
		//
		public static function cos(deg:Number):Number {
			return Math.cos((deg)*CRAG);
		}
		
		//
		// 整数ランダム
		//
		public static function getRandom( end:Number, start:Number = 0 ):int {
			return Math.floor((end - start) * Math.random()) + 1 +start;
		}
		
		//
		// ポイントロケーション変換
		//
		public static function getFieldPoint(obj:Object):Point
		{
			var p:Point = new Point( obj.x, obj.y );
			p = MovieClip(obj).parent.localToGlobal(p);
			return GameMgr.field.globalToLocal(p);
		}
		
		
	}
}
