package  {
	import flash.display.Sprite;
	import Math;
	public class gongju extends Sprite{

		public function gongju() {
		}
		
		public function suiji(qd:Number, geshu:Number, buchang:Number):Number {
			return Math.floor(Math.random() * geshu) * buchang + qd;
		}
		
		public function chuandi(a:Array):Array {
			var i:Number = 0;
			for(i=a.length-1;i>0;i=i-1){
				a[i] = a[i-1];
			}
			return a;
		}
		
		public function xiangdeng(a:Array, b:Array):Boolean {
			if(a.length != b.length){
				return false;
			}
			var i:Number = 0;
			for(i=0;i<a.length;i=i+1){
				if(a[i] != b[i]){
					return false;
				}
			}
			return true;
		}
	}
}
