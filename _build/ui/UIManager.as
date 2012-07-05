package ui {
	
	import flash.utils.Dictionary;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	
	/**
	 * ...
	 * @author Adam Vernon
	 */
	public class UIManager {
		
		//--Singleton management variables--//
		private static var _instance:UIManager;
		private static var _allowInstantiation:Boolean;
		//----------------------------------//
		
		private var _buttonModeDictionary:Dictionary;	//Stores Booleans marking whether each Sprite / key's current custom buttonmode is enabled
		private var _contentCardOffsetDictionary:Dictionary;
		private var _modernContentShown:Boolean = false;
		
		
		public function UIManager() {
			if (! _allowInstantiation) {
				throw new Error("Error: Direct instantiation failed; use instance property instead.");
			}
		}
		
		//--Singleton Enforcer--//
		public static function get instance():UIManager {
 			if (_instance == null) {
				_allowInstantiation = true;
				_instance = new UIManager();
				_allowInstantiation = false;
			}
 			return _instance;
 		}
		//----------------------//
		
		
		/**
		 * Change the (custom) buttonMode of a given Sprite
		 * @param	target - The Sprite to which the behaviour is applied
		 * @param	buttonMode - Whether the buttonMode is being turned on or off
		 */
		public function buttonMode_set(target:Sprite, buttonMode:Boolean):void {
			
			//If the dictionary hasn't been initialised, do so and set up the custom mouse cursor//
			if (! _buttonModeDictionary) {
				_buttonModeDictionary = new Dictionary();
				var pointerCursor = new MouseCursorData();
				pointerCursor.data = new <BitmapData>[new Cursor32Shadow()];
				pointerCursor.frameRate = 0;
				pointerCursor.hotSpot = new Point(3, 1);
				Mouse.registerCursor("PointerCursor", pointerCursor);
			}
			
			//Check whether the Sprite has already been registered for use//
			if (target in _buttonModeDictionary) {
				
				//Only add/remove listeners if the buttonMode state is actually changing//
				if (_buttonModeDictionary[target] != buttonMode) {
					_buttonModeDictionary[target] = buttonMode;
					if (buttonMode) {
						target.addEventListener(MouseEvent.ROLL_OVER, pointerCursor_show);
						target.addEventListener(MouseEvent.ROLL_OUT, pointerCursor_hide);
						mouseOver_check(target, true);
					} else {
						target.removeEventListener(MouseEvent.ROLL_OVER, pointerCursor_show);
						target.removeEventListener(MouseEvent.ROLL_OUT, pointerCursor_hide);
						mouseOver_check(target, false);
					}
				}
				
			//Only add the new entry if pseudo-buttonMode is being turned on//
			} else if (buttonMode) {
				
				_buttonModeDictionary[target] = true;
				target.addEventListener(MouseEvent.ROLL_OVER, pointerCursor_show);
				target.addEventListener(MouseEvent.ROLL_OUT, pointerCursor_hide);
				mouseOver_check(target, true);
			}
		}
		
		/**
		 * Swap the current mouse cursor for the custom graphic
		 * @param	evt
		 */
		private function pointerCursor_show(evt:MouseEvent = null):void {
			Mouse.cursor = "PointerCursor";
		}
		
		/**
		 * Swap the current mouse cursor back to the standard arrow cursor
		 * @param	evt - Optional MouseEvent for 
		 */
		private function pointerCursor_hide(evt:MouseEvent = null):void {
			Mouse.cursor = MouseCursor.ARROW;
		}
		
		private function mouseOver_check(target:Sprite, show:Boolean):void {
			if (target.stage) {
				if (target.hitTestPoint(target.stage.mouseX, target.stage.mouseY, true)) {
					if (show) pointerCursor_show();
					else pointerCursor_hide();
				}
			}
		}
		
		
		
	}
}