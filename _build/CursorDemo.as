package {
	
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import ui.ToggleButton;
	
	/**
	 * ...
	 * @author Adam Vernon
	 */
	public class CursorDemo extends Sprite {
		
		//--In FLA--//
		public var toggle1:ToggleButton;
		public var toggle2:ToggleButton;
		public var catLight:MovieClip;
		//----------//
		
		private var _transitioning:Boolean = false;
		
		public function CursorDemo() {
			ui_init();
		}
		
		private function ui_init():void {
			catLight.gotoAndStop("light_off");
			movieClip_addScript(catLight, "light_off", transition_complete);
			movieClip_addScript(catLight, "light_on", transition_complete);
			
			toggle1.labelTF.text = "LIGHTS OFF";
			toggle2.labelTF.text = "LIGHTS ON";
			
			toggle1.addEventListener(MouseEvent.CLICK, toggle_click);
			toggle2.addEventListener(MouseEvent.CLICK, toggle_click);
			
			toggle1.toggledOn = true;
			toggle2.toggledOn = false;
		}
		
		private function toggle_click(evt:MouseEvent):void {
			if (_transitioning) return;
			
			if (evt.currentTarget == toggle1) {
				if (toggle1.toggledOn) return;
				toggle1.toggledOn = true;
				toggle2.toggledOn = false;
			} else if (evt.currentTarget == toggle2) {
				if (toggle2.toggledOn) return;
				toggle1.toggledOn = false;
				toggle2.toggledOn = true;
			} else {
				return;
			}
			_transitioning = true;
			catLight.play();
		}
		
		private function transition_complete():void {
			catLight.stop();
			_transitioning = false;
		}
		
		private function movieClip_addScript(movieClip:MovieClip, label:String, func:Function):void {
			var labels:Array = movieClip.currentLabels;
			for each (var cLabel:FrameLabel in labels) {
				if (cLabel.name == label) {
					movieClip.addFrameScript(cLabel.frame - 1, func);
					return;
				}
			}
		}
		
	}

}