package rollerGame.env
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import rollerGame.util.Math2;
	import rollerGame.env.GameMgr;
	import rollerGame.env.GameField;

	public class Topography extends MovieClip
	{
//		var f:Boolean = false;
		var lines:Array = [];
		
		var dstock:Array = [];
		
		public function Topography():void 
		{
			setOutLineUTIGAWA(GameField.battleSence.topo.linesman);
			setOutLineSOTOGAWA(GameField.battleSence.topo.linesman2);
			
			setOutLineUTIGAWA(GameField.battleSence.topo.linesman3);
			setOutLineUTIGAWA(GameField.battleSence.topo.linesman4);
			setOutLineUTIGAWA(GameField.battleSence.topo.linesman5);
			setOutLineUTIGAWA(GameField.battleSence.topo.linesman6);
			setOutLineUTIGAWA(GameField.battleSence.topo.linesman7);
		}
		public function clipRay(u:MovieClip,new_x:Number,new_y:Number):Boolean 
		{
			var result:Point;
			// アウトエリアとヒットテスト
//			if ( outArea_mc.hitTestPoint(p.x, p.y, true) ) {

				var p1:Point = u.parent.localToGlobal( new Point(u.x, u.y) );
				p1 = GameField.battleSence.topo.globalToLocal(p1);
				var p2:Point = u.parent.localToGlobal( new Point(new_x, new_y) );
				p2 = GameField.battleSence.topo.globalToLocal(p2);

				// レイクリップ判定
				var nowMoveLine:Line = new Line(p1, p2);
				for ( var i = 0; i < lines.length; i++ ) {
					result = Line.isCross( nowMoveLine, lines[i]);

					// ヒットしたらプレイヤーは交点にクリップ
					if ( result != null ) {
						p1.x = result.x + (Math.cos(ang)==0?0:(Math.cos(ang)>0?1:-1));
						p1.y = result.y + (Math.sin(ang)==0?0:(Math.sin(ang)>0?1:-1));

						p1 = GameField.battleSence.topo.localToGlobal( p1 );
						p1 = u.parent.globalToLocal(p1);
						
						// クリップ位置への移動で隣のラインとあたる場合						
						u.x = p1.x;
						u.y = p1.y;
						return true;
					}
				}
//			}

			u.x = new_x;
			u.y = new_y;
			return false;
		}
		
		function setOutLineUTIGAWA(linesman:MovieClip):void 
		{
			for ( var i:int = 0 ; i < linesman.numChildren - 1; i++ ) {
				var b1:MovieClip = linesman.getChildAt(i) as MovieClip;
				var b2:MovieClip = linesman.getChildAt(i+1) as MovieClip;

				var p1:Point = linesman.localToGlobal( new Point(b1.x, b1.y) );
				p1 = linesman.parent.globalToLocal(p1);
				var p2:Point = linesman.localToGlobal( new Point(b2.x, b2.y) );
				p2 = linesman.parent.globalToLocal(p2);
				lines.push(new Line(p1, p2));
			}
			// ラインの終点と始点を結んだクローズパスを最後に追加します
			b1 = linesman.getChildAt(i) as MovieClip;
			b2 = linesman.getChildAt(0) as MovieClip;
			p1 = linesman.localToGlobal( new Point(b1.x, b1.y) );
			p1 = linesman.parent.globalToLocal(p1);
			p2 = linesman.localToGlobal( new Point(b2.x, b2.y) );
			p2 = linesman.parent.globalToLocal(p2);
			lines.push(new Line(p1, p2));
		}
		
		function setOutLineSOTOGAWA(linesman:MovieClip):void
		{
			for ( var i:int = linesman.numChildren - 1; i > 0; i-- ) {
				var b1:MovieClip = linesman.getChildAt(i) as MovieClip;
				var b2:MovieClip = linesman.getChildAt(i-1) as MovieClip;

				var p1:Point = linesman.localToGlobal( new Point(b1.x, b1.y) );
				p1 = linesman.parent.globalToLocal(p1);
				var p2:Point = linesman.localToGlobal( new Point(b2.x, b2.y) );
				p2 = linesman.parent.globalToLocal(p2);
				lines.push(new Line(p1, p2));
			}
			// ラインの終点と始点を結んだクローズパスを最後に追加します
			b1 = linesman.getChildAt(i) as MovieClip;
			b2 = linesman.getChildAt(linesman.numChildren - 1) as MovieClip;
			p1 = linesman.localToGlobal( new Point(b1.x, b1.y) );
			p1 = linesman.parent.globalToLocal(p1);
			p2 = linesman.localToGlobal( new Point(b2.x, b2.y) );
			p2 = linesman.parent.globalToLocal(p2);
			lines.push(new Line(p1, p2));
		}
		
	}
	
}
var ang:Number;

import flash.geom.*;
import rollerGame.util.Math2;
internal class Line{
        public var p1:Point;
        public var p2:Point;
        public function Line(p1:Point, p2:Point){
                this.p1 = p1;
                this.p2 = p2;
        }
        
        // 直線の交点（線分の交点ではない）
        public static function crossPoint(lhs:Line, rhs:Line):Point {
                var a:Point = new Point(lhs.p2.x - lhs.p1.x, lhs.p2.y- lhs.p1.y);
                var b:Point = new Point(rhs.p2.x - rhs.p1.x, rhs.p2.y- rhs.p1.y);
                var c:Point = new Point(rhs.p1.x - lhs.p1.x, rhs.p1.y- lhs.p1.y);
                
                var result:Point = new Point();
                
                var cross_b_c:Number = b.x*c.y - b.y*c.x;
                var cross_b_a:Number = b.x*a.y - b.y*a.x;
                
                if(cross_b_a == 0)
                return null;
                
                result.x = lhs.p1.x + a.x * cross_b_c / cross_b_a;
                result.y = lhs.p1.y + a.y * cross_b_c / cross_b_a;
                
				ang = Math2.getAngleRag(rhs.p1.x, rhs.p1.y, rhs.p2.x, rhs.p2.y)+(90*Math2.CRAG);
//				ang = Math2.getAngleRag(lhs.p1.x, lhs.p1.y, lhs.p2.x, lhs.p2.y)+(180*Math2.CRAG);
				
                return result;
        }
        
        public static function isCross(lhs:Line, rhs:Line):Point{
                var p:Point = crossPoint(lhs,rhs);
                var bflag:Boolean;
                
				bflag = Boolean(
				(p != null &&
                (p.x - rhs.p1.x) * (p.x - rhs.p2.x) + (p.y - rhs.p1.y) * (p.y - rhs.p2.y) < 0) &&
                ((p.x - lhs.p1.x) * (p.x - lhs.p2.x) + (p.y - lhs.p1.y) * (p.y - lhs.p2.y) < 0)
                );
				
				return ( bflag == true ? p:null);
        }
}
