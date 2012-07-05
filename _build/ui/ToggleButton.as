package ui {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.greensock.TweenMax;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Adam Vernon
	 */
	public class ToggleButton extends Sprite {
		
		//--In FLA--//
		public var over:Sprite;
		public var down:Sprite;
		public var labelTF:TextField;
		//----------//
		
		private var _buttonEnabled:Boolean = true;
		private var _toggledOn:Boolean = false;
		private const _tTime:Number = 0.25;
		
		
		public function ToggleButton() {
			ui_init();
		}
		
		private function ui_init():void {
			TweenMax.allTo([over, down], 0, { autoAlpha:0 } );
			this.mouseChildren = false;
			UIManager.instance.buttonMode_set(this, true);
			this.addEventListener(MouseEvent.ROLL_OVER, mouseEvent);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseEvent);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseEvent);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseEvent);
		}
		
		private function mouseEvent(evt:MouseEvent):void {
			if (! _toggledOn) {
				switch(evt.type) {
					case MouseEvent.ROLL_OVER:
						TweenMax.to(over, _tTime, { autoAlpha:1 } );
						break;
					case MouseEvent.ROLL_OUT:
						TweenMax.allTo([over, down], _tTime, { autoAlpha:0 } );
						break;
					case MouseEvent.MOUSE_DOWN:
						TweenMax.to(down, _tTime, { autoAlpha:1 } );
						break;
					case MouseEvent.MOUSE_UP:
						TweenMax.to(down, _tTime, { autoAlpha:0 } );
						break;
				}
			}
		}
		
		public function get toggledOn():Boolean { return _toggledOn; }
		public function set toggledOn(value:Boolean):void {
			if (value != _toggledOn) {
				_toggledOn = value;
				if (_toggledOn) {
					this.mouseEnabled = false;
					UIManager.instance.buttonMode_set(this, false);
					TweenMax.to(down, _tTime, { autoAlpha:1 } );
					TweenMax.to(over, _tTime, { autoAlpha:0 } );
				} else {
					this.mouseEnabled = true;
					UIManager.instance.buttonMode_set(this, true);
					TweenMax.allTo([over, down], _tTime, { autoAlpha:0 } );
				}
			}
		}
		
		public function get buttonEnabled():Boolean { return _buttonEnabled; }
		public function set buttonEnabled(value:Boolean):void {
			_buttonEnabled = value;
			if (_buttonEnabled) {
				this.mouseEnabled = true;
			} else {
				this.mouseEnabled = false;
				TweenMax.allTo([over, down], _tTime, { autoAlpha:0 } );
			}
		}
		
	}

}