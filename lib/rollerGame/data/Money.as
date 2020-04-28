package rollerGame.data 
{
	import rollerGame.unit.Unit;
	import rollerGame.util.Math2;
	import rollerGame.env.GameMgr;

	public class Money
	{
		
		public function Money() 
		{

		}
		
		// 撒く
		public static function sprinkle(m:int, u:Unit, ang:Number):void 
		{
			var co:Coin;
			var c:int;
			for each (var elem:int in Coin.coinList )
			{
				for ( c = m; c >= elem; c -= elem) {
					co = new Coin(elem);
					co.setGoToPoint(u.x, u.y, ang);
					m -= elem;
				}
				
			}
		}
	}

}