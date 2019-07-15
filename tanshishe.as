package  {
	import flash.display.Sprite;
	import she;
	import gongju;
	import fangkuai;
	import Math;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	// 1、左侧玩家用ASDW控制方向，右侧玩家用方向键控制方向
	// 2、吃到食物后，自身长度加一
	// 3、撞到对方的身子，自己死；撞到对方的尾巴，对方死；撞到头忽略
	// 4、撞到自己忽略
	// 5、撞到墙，自己死
	
	public class tanshishe extends Sprite{
		public var qdx:Number = 50;
		public var qdy:Number = 50;
		public var bc:Number = 15;
		public var cdx:Number = 30;
		public var cdy:Number = 20;
		public var she1:she = null;
		public var she2:she = null;
		public var shecd:Number = 5;
		public var gj:gongju = new gongju();
		public var t:Timer = new Timer(150);
		public var shiwu:fangkuai = null;
		public var tf:TextField = new TextField();
			
		public function tanshishe() {
			huawangge();
			chushihua();
		}
		
		public function chushihua():void {
			this.she1 = huashe("p1", this.qdx + this.bc * (this.cdx - 1), 
				this.qdy + this.bc * (this.cdy - this.shecd), 0xEEEE00, 0x66CC66);
			stage.addChild(this.she1);
			this.she2 = huashe("p2", this.qdx, this.qdy + this.bc * (this.cdy - this.shecd), 
				0xCC0000, 0x6666CC);
			stage.addChild(this.she2);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kaishi);
			huashiwu();
			xianshi("按空格键开始游戏");
			this.t.addEventListener(TimerEvent.TIMER, gameover);
			this.t.addEventListener(TimerEvent.TIMER, chishiwu);
			
			this.t.start();
		}
		
		public function xianshi(str:String):void {
			stage.addChild(this.tf);
			this.tf.text = str;
			this.tf.x = this.qdx;
			this.tf.y = this.qdy - 3 * this.bc;
			this.tf.width = this.bc * this.cdx;
			this.tf.textColor = 0x0000FF;
			var tft:TextFormat = new TextFormat();
			tft.size = 26;
			tft.align = "center";
			this.tf.setTextFormat(tft);
		}
		
		public function huashiwu():void {
			var posix:Number = 0;
			var posiy:Number = 0;
			var flag:Number = 0;
			for(;;){
				flag = 0;
				this.shiwu = new fangkuai(bc, 0xEE00EE);
				posix = gj.suiji(this.qdx, this.cdx-1, this.bc);
				posiy = gj.suiji(this.qdy, this.cdy-1, this.bc);
				stage.addChild(this.shiwu);
				this.shiwu.x = posix;
				this.shiwu.y = posiy;
				var i:Number = 0;
				for(i=0;i<this.she1.shenti.length; i=i+1){
					if(this.she1.shenti[i].x == posix){
						if(this.she1.shenti[i].y == posiy){
							stage.removeChild(this.shiwu);
							flag = 1;
							break;
						}
					}
				}
				for(i=0;i<this.she2.shenti.length; i=i+1){
					if(this.she2.shenti[i].x == posix){
						if(this.she2.shenti[i].y == posiy){
							stage.removeChild(this.shiwu);
							flag = 1;
							break;
						}
					}
				}
				if(flag == 0){
					break;
				}
			}
		}
		
		public function chishiwu(e:TimerEvent):void {
			this.she1.xiugaifangxiang();
			this.she2.xiugaifangxiang();
			// 从左吃
			if(this.shiwu.x - this.bc == this.she1.shenti[0].x){
				if(this.shiwu.y == this.she1.shenti[0].y){
					if(this.gj.xiangdeng(this.she1.fangxiang[0], [1, 0])){
						this.she1.zhuijia(this.shiwu);
						huashiwu();
					}
				}
			}
			
			if(this.shiwu.x - this.bc == this.she2.shenti[0].x){
				if(this.shiwu.y == this.she2.shenti[0].y){
					if(this.gj.xiangdeng(this.she2.fangxiang[0], [1, 0])){
						this.she2.zhuijia(this.shiwu);
						huashiwu();
					}
				}
			}	
			// 从右吃
			if(this.shiwu.x + this.bc == this.she1.shenti[0].x){
				if(this.shiwu.y == this.she1.shenti[0].y){
					if(this.gj.xiangdeng(this.she1.fangxiang[0], [-1, 0])){
						this.she1.zhuijia(this.shiwu);
						huashiwu();
					}
				}
			}
			if(this.shiwu.x + this.bc == this.she2.shenti[0].x){
				if(this.shiwu.y == this.she2.shenti[0].y){
					if(this.gj.xiangdeng(this.she2.fangxiang[0], [-1, 0])){
						this.she2.zhuijia(this.shiwu);
						huashiwu();
					}
				}
			}
			// 从上吃
			if(this.shiwu.x == this.she1.shenti[0].x){
				if(this.shiwu.y - this.bc == this.she1.shenti[0].y){
					if(this.gj.xiangdeng(this.she1.fangxiang[0], [0, 1])){
						this.she1.zhuijia(this.shiwu);
						huashiwu();
					}
				}
			}
			if(this.shiwu.x == this.she2.shenti[0].x){
				if(this.shiwu.y - this.bc == this.she2.shenti[0].y){
					if(this.gj.xiangdeng(this.she2.fangxiang[0], [0, 1])){
						this.she2.zhuijia(this.shiwu);
						huashiwu();
					}
				}
			}
			// 从下吃
			if(this.shiwu.x == this.she1.shenti[0].x){
				if(this.shiwu.y + this.bc == this.she1.shenti[0].y){
					if(this.gj.xiangdeng(this.she1.fangxiang[0], [0, -1])){
						this.she1.zhuijia(this.shiwu);
						huashiwu();
					}
				}
			}
			if(this.shiwu.x == this.she2.shenti[0].x){
				if(this.shiwu.y + this.bc == this.she2.shenti[0].y){
					if(this.gj.xiangdeng(this.she2.fangxiang[0], [0, -1])){
						this.she2.zhuijia(this.shiwu);
						huashiwu();
					}
				}
			}
		}
		
		public function gameover(e:TimerEvent):void {
			var win1:Number = 0;
			var win2:Number = 0;
			if(this.she1.shenti[0].x == this.qdx - this.bc){
				if(gj.xiangdeng(this.she1.fangxiang[0], [-1, 0])){
					this.she1.tingzhi();
					this.she2.tingzhi();
					win2 = 1;
				}
			}
			if(this.she1.shenti[0].x == this.qdx + this.bc * this.cdx){
				if(gj.xiangdeng(this.she1.fangxiang[0], [1, 0])){
					this.she1.tingzhi();
					this.she2.tingzhi();
					win2 = 1;
				}
			}
			if(this.she1.shenti[0].y == this.qdy - this.bc){
				if(gj.xiangdeng(this.she1.fangxiang[0], [0, -1])){
					this.she1.tingzhi();
					this.she2.tingzhi();
					win2 = 1;
				}
			}
			if(this.she1.shenti[0].y == this.qdy + this.bc * this.cdy){
				if(gj.xiangdeng(this.she1.fangxiang[0], [0, 1])){
					this.she1.tingzhi();
					this.she2.tingzhi();
					win2 = 1;
				}
			}
			if(this.she2.shenti[0].x == this.qdx - this.bc){
				if(gj.xiangdeng(this.she2.fangxiang[0], [-1, 0])){
					this.she2.tingzhi();
					this.she1.tingzhi();
					win1 = 1;
				}
			}
			if(this.she2.shenti[0].x == this.qdx + this.bc * this.cdx){
				if(gj.xiangdeng(this.she2.fangxiang[0], [1, 0])){
					this.she2.tingzhi();
					this.she1.tingzhi();
					win1 = 1;
				}
			}
			if(this.she2.shenti[0].y == this.qdy - this.bc){
				if(gj.xiangdeng(this.she2.fangxiang[0], [0, -1])){
					this.she2.tingzhi();
					this.she1.tingzhi();
					win1 = 1;
				}
			}
			if(this.she2.shenti[0].y == this.qdy + this.bc * this.cdy){
				if(gj.xiangdeng(this.she2.fangxiang[0], [0, 1])){
					this.she2.tingzhi();
					this.she1.tingzhi();
					win1 = 1;
				}
			}
			if(this.she1.shenti[0].x == this.she2.shenti[this.she2.shenti.length-1].x){
				if(this.she1.shenti[0].y == this.she2.shenti[this.she2.shenti.length-1].y){
					this.she2.tingzhi();
					this.she1.tingzhi();
					win1 = 1;
				}
			}
			if(this.she2.shenti[0].x == this.she1.shenti[this.she1.shenti.length-1].x){
				if(this.she2.shenti[0].y == this.she1.shenti[this.she1.shenti.length-1].y){
					this.she2.tingzhi();
					this.she1.tingzhi();
					win2 = 1;
				}
			}
			var i:Number = 0;
			for(i=0; i<this.she1.shenti.length-1; i=i+1){
				if(this.she2.shenti[0].x == this.she1.shenti[i].x){
					if(this.she2.shenti[0].y == this.she1.shenti[i].y){
						this.she2.tingzhi();
						this.she1.tingzhi();
						win1 = 1;
					}
				}
			}
			for(i=0; i<this.she2.shenti.length-1; i=i+1){
				if(this.she1.shenti[0].x == this.she2.shenti[i].x){
					if(this.she1.shenti[0].y == this.she2.shenti[i].y){
						this.she2.tingzhi();
						this.she1.tingzhi();
						win2 = 1;
					}
				}
			}
			if((win1==1)&&(win2==1)){
				this.xianshi("平局，按回车键重开");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, kaishi);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, chongkai);
				this.t.stop();
			}else if(win1==1){
				this.xianshi("右侧玩家胜出，按回车键重开");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, kaishi);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, chongkai);
				this.t.stop();
			}else if(win2==1){
				this.xianshi("左侧玩家胜出，按回车键重开");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, kaishi);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, chongkai);
				this.t.stop();
			}
		}
		
		public function chongkai(e:KeyboardEvent):void {
			if(e.keyCode == Keyboard.ENTER){
				this.she1.xiaoshi();
				this.she2.xiaoshi();
				this.t.reset();
				stage.removeChild(this.shiwu);
				chushihua();
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, chongkai);
			}
		}
		
		public function kaishi(e:KeyboardEvent):void {
			if(e.keyCode == Keyboard.SPACE){
				this.she1.kaishi();
				this.she2.kaishi();
			}
			if(e.keyCode == Keyboard.LEFT){
				this.she1.shezhizhx([1, 0, 0, 0]);
			}
			if(e.keyCode == Keyboard.RIGHT){
				this.she1.shezhizhx([0, 1, 0, 0]);	
			}
			if(e.keyCode == Keyboard.UP){
				this.she1.shezhizhx([0, 0, 1, 0]);
			}
			if(e.keyCode == Keyboard.DOWN){
				this.she1.shezhizhx([0, 0, 0, 1]);
			}
			if(e.keyCode == Keyboard.A){
				this.she2.shezhizhx([1, 0, 0, 0]);
			}
			if(e.keyCode == Keyboard.D){
				this.she2.shezhizhx([0, 1, 0, 0]);
			}
			if(e.keyCode == Keyboard.W){
				this.she2.shezhizhx([0, 0, 1, 0]);
			}
			if(e.keyCode == Keyboard.S){
				this.she2.shezhizhx([0, 0, 0, 1]);
			}
		}

		public function huashe(sname:String, posix:Number, posiy:Number, ys1:Number, ys2:Number):she {
			return new she(sname, posix, posiy, ys1, ys2, this.shecd, this.bc);
		}
		
		public function huawangge():void {
			var i:Number = 0 ;
			graphics.lineStyle(1, 0x999999, 1);
			for(i=0;i<=this.cdy;i=i+1){
				graphics.moveTo(this.qdx, this.qdy + this.bc * i);
				graphics.lineTo(this.qdx + this.bc * this.cdx, this.qdy + this.bc * i);
			}
			for(i=0;i<=this.cdx;i=i+1){
				graphics.moveTo(this.qdx + this.bc * i, this.qdy);
				graphics.lineTo(this.qdx + this.bc * i, this.qdy + this.bc * this.cdy);
			}
		}
	}
	
}
