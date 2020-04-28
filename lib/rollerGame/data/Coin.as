package rollerGame.data 
{
	import com.flashdynamix.motion.TweensyGroup;
	import com.flashdynamix.motion.TweensyTimeline;
	import com.flashdynamix.motion.guides.Bezier2D;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import rollerGame.util.Math2;
	import rollerGame.env.GameField;
	import rollerGame.env.GameMgr;
	
	import com.flashdynamix.motion.Tweensy;

	/**
	 * ...
	 * @author ...
	 */
	public class Coin extends MovieClip
	{
		public static const COIN_1:int = 1;
		public static const COIN_10:int = 10;
		public static const COIN_100:int = 100;
		public static const COIN_1000:int = 1000;
		public static const COIN_10000:int = 10000;

		public var tt:TweensyTimeline;
		public var value:Number = COIN_1;
		public static var coinList:Array = new Array( COIN_10000, COIN_1000, COIN_100, COIN_10, COIN_1 );
		public var seCharin:SE_Charin = new SE_Charin;
		
		private var tween:TweensyGroup;
		private var ox:Number, oy:Number;
		
		public function Coin(kind:Number)
		{
			value = kind;
			gotoAndStop( coinList.length - coinList.indexOf( kind ) );
			
			seCharin.play();
			
			// コインをフィールドに登録
			GameField.moneyField.addChild(this);
		}
		public function setGoToPoint(x:Number,y:Number,r:Number):void 
		{
			this.x = this.ox = x;
			this.y = this.oy = y;
			this.rotation = r;
			var ang = r + Math2.getRandom(60, 0) - 30;
			var k = Math.random()*2+1;
			
			tween = new TweensyGroup();
			tween.onUpdate = up;
			tween.onUpdateParams = [this];
			function up(c:Coin):void 
			{
				var tx:Number = c.x;
				var ty:Number = c.y;
				c.x = c.ox;
				c.y = c.oy;
				c.ox = tx;
				c.oy = ty;
				if ( GameMgr.topo.clipRay(c, c.ox, c.oy) ) {
					//trace( c, c.ox, c.oy );
					clearGoToPoint();
				}
				else {
					c.ox = c.x;
					c.oy = c.y;
					c.x = tx;
					c.y = ty;
				}
				
			}
			var bezire:Bezier2D = new Bezier2D( this, true, false, false );
			bezire.push( new Point( x, y ) );
			bezire.push( new Point( x+(20*k)*Math2.cos(ang-10), y+(20*k)*Math2.sin(ang-10) ) );
			bezire.push( new Point( x+(70*k)*Math2.cos(ang+20), y+(70*k)*Math2.sin(ang+20) ) );
			tt = tween.to(bezire, { position:1 } );
		}
		public function clearGoToPoint():void 
		{
			tween.onUpdate = null;
			tween.dispose(); 
			tween = null;
			Tweensy.remove(tt);
		}
		public function del():void 
		{
			if ( tween != null ) {
				tween.onUpdate = null;
				tween.dispose(); 
				tween = null;
				Tweensy.remove(tt);
			}
			GameField.moneyField.removeChild(this);
		}
	}

}