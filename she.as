package  {
	import flash.display.Sprite;
	import fangkuai;
	import gongju;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class she extends Sprite{
		public var sname:String = "";
		public var sposix:Number = 0;
		public var sposiy:Number = 0;
		public var bc:Number = 0;
		public var ys1:Number = 0x000000;
		public var ys2:Number = 0x000000;
		public var shecd:Number = 0;
		public var shenti:Array = [];
		public var fangxiang:Array = [];
		public var t:Timer = new Timer(150);
		public var zhuanxiang:Array = [0, 0, 0, 0];
		public var gj:gongju = new gongju();
		
		public function she(sname:String, posix:Number, posiy:Number, ys1:Number, ys2:Number, shecd:Number, bc:Number) {
			this.sname = sname;
			this.sposix = posix;
			this.sposiy = posiy;
			this.bc = bc;
			this.ys1 = ys1;
			this.ys2 = ys2;
			this.shecd = shecd;
			this.zhuanxiang = [0, 0, 0, 0];
			huitu();
			this.t.addEventListener(TimerEvent.TIMER, yundong);
		}
		
		public function tingzhi():void {
			this.t.stop();
		}
		
		public function shezhizhx(zx:Array):void {
			this.zhuanxiang = zx;
		}
		
		public function zhuijia(shiwu:fangkuai):Boolean {
			// 尾巴向左
			if(this.gj.xiangdeng(this.fangxiang[this.fangxiang.length - 1], [-1, 0])){
				shiwu.x = this.shenti[this.shenti.length-1].x + this.bc;
				shiwu.y = this.shenti[this.shenti.length-1].y;
				shiwu.shezhiys(this.ys2);
				this.addChild(shiwu);
				this.shenti.push(shiwu);
				this.fangxiang.push(this.fangxiang[this.fangxiang.length-1]);
				return true;
			}
			// 尾巴向右
			if(this.gj.xiangdeng(this.fangxiang[this.fangxiang.length - 1], [1, 0])){
				shiwu.x = this.shenti[this.shenti.length-1].x - this.bc;
				shiwu.y = this.shenti[this.shenti.length-1].y;
				shiwu.shezhiys(this.ys2);
				this.addChild(shiwu);
				this.shenti.push(shiwu);
				this.fangxiang.push(this.fangxiang[this.fangxiang.length-1]);
			}
			// 尾巴向上
			if(this.gj.xiangdeng(this.fangxiang[this.fangxiang.length - 1], [0, -1])){
				shiwu.x = this.shenti[this.shenti.length-1].x;
				shiwu.y = this.shenti[this.shenti.length-1].y + this.bc;
				shiwu.shezhiys(this.ys2);
				this.addChild(shiwu);
				this.shenti.push(shiwu);
				this.fangxiang.push(this.fangxiang[this.fangxiang.length-1]);
			}
			// 尾巴向下
			if(this.gj.xiangdeng(this.fangxiang[this.fangxiang.length - 1], [0, 1])){
				shiwu.x = this.shenti[this.shenti.length-1].x;
				shiwu.y = this.shenti[this.shenti.length-1].y - this.bc;
				shiwu.shezhiys(this.ys2);
				this.addChild(shiwu);
				this.shenti.push(shiwu);
				this.fangxiang.push(this.fangxiang[this.fangxiang.length-1]);
			}
			return false;
		}
		
		public function huitu():void {
			var fk:fangkuai = new fangkuai(this.bc, this.ys1);
			this.addChild(fk);
			fk.x = this.sposix;
			fk.y = this.sposiy;
			var fx:Array = [0, -1];
			this.fangxiang.push(fx);
			this.shenti.push(fk);
			var i:Number = 1;
			for(i=1;i<this.shecd;i=i+1){
				fk = new fangkuai(this.bc, this.ys2);
				this.addChild(fk);
				fk.x = this.sposix;
				fk.y = this.sposiy + this.bc * i;
				fx = [0, -1];
				this.fangxiang.push(fx);
				this.shenti.push(fk);
			}
		}
		
		public function xiugaifangxiang():Boolean {
			if(gj.xiangdeng(this.zhuanxiang, [1, 0, 0, 0])){
				if(!gj.xiangdeng(this.fangxiang[0], [1, 0])){
					this.fangxiang[0] = [-1, 0];
					return true;
				}
			}
			if(gj.xiangdeng(this.zhuanxiang, [0, 1, 0, 0])){
				if(!gj.xiangdeng(this.fangxiang[0], [-1, 0])){
					this.fangxiang[0] = [1, 0];
					return true;
				}
			}
			if(gj.xiangdeng(this.zhuanxiang, [0, 0, 1, 0])){
				if(!gj.xiangdeng(this.fangxiang[0], [0, 1])){
					this.fangxiang[0] = [0, -1];
					return true;
				}
			}
			if(gj.xiangdeng(this.zhuanxiang, [0, 0, 0, 1])){
				if(!gj.xiangdeng(this.fangxiang[0], [0, -1])){
					this.fangxiang[0] = [0, 1];
					return true;
				}
			}
			return false;
		}
		
		public function yundong(e:TimerEvent):void {
			var i:Number = 0;
			for(i=0;i<this.shenti.length;i=i+1){
				this.shenti[i].x = this.shenti[i].x + this.bc * this.fangxiang[i][0];
				this.shenti[i].y = this.shenti[i].y + this.bc * this.fangxiang[i][1];
			}
			gj.chuandi(this.fangxiang);
		}
		
		public function kaishi():void {
			this.t.start();
		}
		
		public function xiaoshi():void {
			this.fangxiang = [];
			var i:Number = 0;
			for(i=0;i<this.shenti.length;i=i+1){
				this.removeChild(this.shenti[i]);
			}
		}

	}
	
}
