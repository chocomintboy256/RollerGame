package rollerGame.data 
{
	/**
	 * Unitインスタンス、lifeGaugeインスタンスと表示域の管理担当
	 * 
	 */
	// ユニットマネージャ経由でユニット作る
	import flash.utils.getDefinitionByName;
	import rollerGame.unit.Player;
	import rollerGame.unit.Unit;
	import rollerGame.console.LifeGauge;
	import rollerGame.env.GameField;
	public class UnitData
	{
		
		public var insUnit:Unit;
		public var insLifeGauge:LifeGauge;
		
		public function UnitData(cls:String) {
			var c:Class = getDefinitionByName(cls) as Class;
			insUnit = Unit( new c() );
			if ( c == Player ) { GameField.playerField.addChild(insUnit); }
			else GameField.unitField.addChild(insUnit);
			insLifeGauge = new LifeGauge(insUnit);
			GameField.gaugeField.addChild(insLifeGauge);
		}
		public function remove():void 
		{
			insLifeGauge.parent.removeChild(insLifeGauge);
			insLifeGauge = null;
			insUnit.parent.removeChild(insUnit);
			insUnit = null;
		}
		
	}

}