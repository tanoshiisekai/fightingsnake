package  {
	import flash.display.Sprite;
	
	public class fangkuai extends Sprite{

		public var bc:Number = 0;
		public var ys:Number = 0x000000;
		
		public function fangkuai(bc:Number, ys:Number) {
			this.ys = ys;
			this.bc = bc;
			huitu();
		}
		
		public function huitu():void {
			graphics.lineStyle(1, 0x999999, 1);
			graphics.beginFill(this.ys);
			graphics.moveTo(0, 0);
			graphics.lineTo(0, this.bc);
			graphics.lineTo(this.bc, this.bc);
			graphics.lineTo(this.bc, 0);
			graphics.lineTo(0, 0);
			graphics.endFill();
		}
		
		public function shezhiys(ys:Number):void {
			this.ys = ys;
			huitu();
		}

	}
	
}
