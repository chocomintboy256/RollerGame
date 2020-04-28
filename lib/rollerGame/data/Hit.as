package rollerGame.data {
	public dynamic class Hit {
		// 持続系
		public var pow:Number;	// 抵抗あり:Unit.weight
		public var ang:Number;
		// 無抵抗
		public var damage:Number;
		public var mutekiTime:Number;
		public var koutyokuTime:Number;
		public var smash:Boolean;
		
		public function Hit(pow:Number = 0, ang:Number = 0, damage:Number = 0, mutekiTime:Number = 15, koutyokuTime:Number = 10, smash:Boolean = false ) {
			this.pow = pow;
			this.ang = ang;
			this.damage = damage;
			this.mutekiTime = mutekiTime;
			this.koutyokuTime= koutyokuTime;
			this.smash = smash;
		}
	}
}
