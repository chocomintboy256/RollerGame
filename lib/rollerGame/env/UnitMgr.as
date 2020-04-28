package rollerGame.env 
{
	// 関連
	import rollerGame.data.UnitData;
	import rollerGame.unit.Unit;
	
	public class UnitMgr
	{
		private static var unitDataList:Array;
		function UnitMgr() {
			unitDataList = new Array();
		};
		
		public static function create(cls_name:String):Unit
		{
			var ud:UnitData = new UnitData(cls_name);
			unitDataList.push(ud);
			ud.insUnit.dataID = unitDataList.length-1;
			return ud.insUnit;
		}
		public static function remove(u:Unit):void
		{
			for (var i = 0; i < unitDataList.length; ) 
			{
				if ( unitDataList[i].insUnit == u ) {
					unitDataList[i].remove();
					unitDataList.splice(i, 1);
				}
				else i++;
			}
		}
		public static function gaugeDisp():void
		{
			for each ( var elem:Object in unitDataList ) {
				elem.insLifeGauge.action();
			}
		}		
	}
}