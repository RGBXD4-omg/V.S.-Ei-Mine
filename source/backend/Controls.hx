package backend;

import flixel.input.gamepad.FlxGamepadButton;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.mappings.FlxGamepadMapping;
import flixel.input.keyboard.FlxKey;
#if android
import mobile.MobileControls;
import mobile.FlxVirtualPad;
import mobile.FlxHitbox;
#end
	
class Controls
{
	//Keeping same use cases on stuff for it to be easier to understand/use
	//I'd have removed it but this makes it a lot less annoying to use in my opinion

	//You do NOT have to create these variables/getters for adding new keys,
	//but you will instead have to use:
	//   controls.justPressed("ui_up")   instead of   controls.UI_UP

	//Dumb but easily usable code, or Smart but complicated? Your choice.
	//Also idk how to use macros they're weird as fuck lol

	// Pressed buttons (directions)
	public var UI_UP_P(get, never):Bool;
	public var UI_DOWN_P(get, never):Bool;
	public var UI_LEFT_P(get, never):Bool;
	public var UI_RIGHT_P(get, never):Bool;
	public var NOTE_UP_P(get, never):Bool;
	public var NOTE_DOWN_P(get, never):Bool;
	public var NOTE_LEFT_P(get, never):Bool;
	public var NOTE_RIGHT_P(get, never):Bool;
	public var Q_P(get, never):Bool;
        public var E_P(get, never):Bool;
	private function get_UI_UP_P() return justPressed('ui_up');
	private function get_UI_DOWN_P() return justPressed('ui_down');
	private function get_UI_LEFT_P() return justPressed('ui_left');
	private function get_UI_RIGHT_P() return justPressed('ui_right');
	private function get_NOTE_UP_P() return justPressed('note_up');
	private function get_NOTE_DOWN_P() return justPressed('note_down');
	private function get_NOTE_LEFT_P() return justPressed('note_left');
	private function get_NOTE_RIGHT_P() return justPressed('note_right');
        private function get_E_P() return justPressed('e');
	private function get_Q_P() return justPressed('q');
	
	// Held buttons (directions)
	public var UI_UP(get, never):Bool;
	public var UI_DOWN(get, never):Bool;
	public var UI_LEFT(get, never):Bool;
	public var UI_RIGHT(get, never):Bool;
	public var NOTE_UP(get, never):Bool;
	public var NOTE_DOWN(get, never):Bool;
	public var NOTE_LEFT(get, never):Bool;
	public var NOTE_RIGHT(get, never):Bool;
	public var Q(get, never):Bool;
        public var E(get, never):Bool;
	private function get_UI_UP() return pressed('ui_up');
	private function get_UI_DOWN() return pressed('ui_down');
	private function get_UI_LEFT() return pressed('ui_left');
	private function get_UI_RIGHT() return pressed('ui_right');
	private function get_NOTE_UP() return pressed('note_up');
	private function get_NOTE_DOWN() return pressed('note_down');
	private function get_NOTE_LEFT() return pressed('note_left');
	private function get_NOTE_RIGHT() return pressed('note_right');
	private function get_E() return justPressed('e');
	private function get_Q() return justPressed('q');


	// Released buttons (directions)
	public var UI_UP_R(get, never):Bool;
	public var UI_DOWN_R(get, never):Bool;
	public var UI_LEFT_R(get, never):Bool;
	public var UI_RIGHT_R(get, never):Bool;
	public var NOTE_UP_R(get, never):Bool;
	public var NOTE_DOWN_R(get, never):Bool;
	public var NOTE_LEFT_R(get, never):Bool;
	public var NOTE_RIGHT_R(get, never):Bool;
	public var Q_R(get, never):Bool;
        public var E_R(get, never):Bool;
	private function get_UI_UP_R() return justReleased('ui_up');
	private function get_UI_DOWN_R() return justReleased('ui_down');
	private function get_UI_LEFT_R() return justReleased('ui_left');
	private function get_UI_RIGHT_R() return justReleased('ui_right');
	private function get_NOTE_UP_R() return justReleased('note_up');
	private function get_NOTE_DOWN_R() return justReleased('note_down');
	private function get_NOTE_LEFT_R() return justReleased('note_left');
	private function get_NOTE_RIGHT_R() return justReleased('note_right');
	private function get_E_R() return justPressed('e');
	private function get_Q_R() return justPressed('q');

	// Pressed buttons (others)
	public var ACCEPT(get, never):Bool;
	public var BACK(get, never):Bool;
	public var PAUSE(get, never):Bool;
	public var RESET(get, never):Bool;
	private function get_ACCEPT() return justPressed('accept');
	private function get_BACK() return justPressed('back');
	private function get_PAUSE() return justPressed('pause');
	private function get_RESET() return justPressed('reset');

        public static var CheckControl:Bool = false;
	public static var CheckPress:Bool = false;

	//Gamepad & Keyboard stuff
	public var keyboardBinds:Map<String, Array<FlxKey>>;
	public var gamepadBinds:Map<String, Array<FlxGamepadInputID>>;
	public function justPressed(key:String)
	{
		var result:Bool = (FlxG.keys.anyJustPressed(keyboardBinds[key]) == true);
		if(result) controllerMode = false;

		return result || _myGamepadJustPressed(gamepadBinds[key]) == true #if android || checkAndroidControl_justPressed(key) == true #end;
	}

	public function pressed(key:String)
	{
		var result:Bool = (FlxG.keys.anyPressed(keyboardBinds[key]) == true);
		if(result) controllerMode = false;

		return result || _myGamepadPressed(gamepadBinds[key]) == true #if android || checkAndroidControl_pressed(key) == true #end;
	}

	public function justReleased(key:String)
	{
		var result:Bool = (FlxG.keys.anyJustReleased(keyboardBinds[key]) == true);
		if(result) controllerMode = false;

		return result || _myGamepadJustReleased(gamepadBinds[key]) == true #if android || checkAndroidControl_justReleased(key) == true #end;
	}

	public var controllerMode:Bool = false;
	private function _myGamepadJustPressed(keys:Array<FlxGamepadInputID>):Bool
	{
		if(keys != null)
		{
			for (key in keys)
			{
				if (FlxG.gamepads.anyJustPressed(key) == true)
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}
	private function _myGamepadPressed(keys:Array<FlxGamepadInputID>):Bool
	{
		if(keys != null)
		{
			for (key in keys)
			{
				if (FlxG.gamepads.anyPressed(key) == true)
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}
	private function _myGamepadJustReleased(keys:Array<FlxGamepadInputID>):Bool
	{
		if(keys != null)
		{
			for (key in keys)
			{
				if (FlxG.gamepads.anyJustReleased(key) == true)
				{
					controllerMode = true;
					return true;
				}
			}
		}
		return false;
	}

	#if android
	private function checkAndroidControl_justPressed(key:String):Bool
	{
	    var result:Bool = false;	    

	    if (CheckPress){
		if (key == 'accept'){
    		    result = (MusicBeatState.virtualPad.buttonA.justPressed == true);
    		    if(result) {controllerMode = true; return true;}
		}
		if (key == 'ui_left'){
        	    result = (MusicBeatState.virtualPad.buttonLeft.justPressed == true);
        	    if(result) {controllerMode = true; return true;}
        	}
        	if (key == 'ui_right'){
        	    result = (MusicBeatState.virtualPad.buttonRight.justPressed == true);
    		    if(result) {controllerMode = true; return true;}
		}
	    }
		//------------------note
		if (CheckControl){
    		if (MusicBeatState.checkHitbox){
    		    if (key == 'note_up'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonUp.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonDown.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonLeft.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonRight.justPressed == true);
        		if(result) {controllerMode = true; return true;}
    		    }
		}
		    if (MusicBeatState.checkh1){
		        if (key == 'note_up'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonUp.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonDown.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonLeft.justPressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonRight.justPressed == true);
        		if(result) {controllerMode = true; return true;}
			}
			if (key == 'q'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonQ.justPressed == true);
        		if(result) {controllerMode = true; return true;}
			}
			if (key == 'e'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonE.justPressed == true);
        		if(result) {controllerMode = true; return true;}
			}
		    }
	    }//CheckControl
	    return false;
    }        
    
    private function checkAndroidControl_pressed(key:String):Bool
    {
    var result:Bool = false;    

	    if (CheckPress){
		if (key == 'accept'){
    		    result = (MusicBeatState.virtualPad.buttonA.pressed == true);
    		    if(result) {controllerMode = true; return true;}
		}
		if (key == 'ui_left'){
        	    result = (MusicBeatState.virtualPad.buttonLeft.pressed == true);
        	    if(result) {controllerMode = true; return true;}
        	}
        	if (key == 'ui_right'){
        	    result = (MusicBeatState.virtualPad.buttonRight.pressed == true);
    		    if(result) {controllerMode = true; return true;}
		}
	    }
		//------------------note
		if (CheckControl){
    		if (MusicBeatState.checkHitbox){
    		    if (key == 'note_up'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonUp.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonDown.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonLeft.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonRight.pressed == true);
        		if(result) {controllerMode = true; return true;}
    		    }
		}
		    if (MusicBeatState.checkh1){
		        if (key == 'note_up'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonUp.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonDown.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonLeft.pressed == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonRight.pressed == true);
        		if(result) {controllerMode = true; return true;}
			}
			if (key == 'q'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonQ.pressed == true);
        		if(result) {controllerMode = true; return true;}
			}
			if (key == 'e'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonE.pressed == true);
        		if(result) {controllerMode = true; return true;}
			}
		    }
	    }//CheckControl
        return false;
	   // if (result) return true;
    }
    
    private function checkAndroidControl_justReleased(key:String):Bool
    {
    var result:Bool = false;    

	    if (CheckPress){
		if (key == 'accept'){
    		result = (MusicBeatState.virtualPad.buttonA.justReleased == true);
    		if(result) {controllerMode = true; return true;}
		}
		if (key == 'ui_left'){
        	result = (MusicBeatState.virtualPad.buttonLeft.justReleased == true);
        	if(result) {controllerMode = true; return true;}
        	}
                if (key == 'ui_right'){
        	result = (MusicBeatState.virtualPad.buttonRight.justReleased == true);
    	       if(result) {controllerMode = true; return true;}
		}
	    }
		//------------------note
		if (CheckControl){
    		if (MusicBeatState.checkHitbox){
    		    if (key == 'note_up'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonUp.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonDown.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonLeft.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonRight.justReleased == true);
        		if(result) {controllerMode = true; return true;}
    		    }
		}
		    if (MusicBeatState.checkh1){
		        if (key == 'note_up'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonUp.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_down'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonDown.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_left'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonLeft.justReleased == true);
        		if(result) {controllerMode = true; return true;}
        		}
        		if (key == 'note_right'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonRight.justReleased == true);
        		if(result) {controllerMode = true; return true;}
			}
			if (key == 'q'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonQ.justReleased == true);
        		if(result) {controllerMode = true; return true;}
			}
			if (key == 'e'){
        		result = (MusicBeatState.mobileControls.hitbox.buttonE.justReleased == true);
        		if(result) {controllerMode = true; return true;}
			}
		    }
	    }//CheckControl
	    return false;
	  //  if (result) return true;    
    }    
    #end

	// IGNORE THESE
	public static var instance:Controls;
	public function new()
	{
		keyboardBinds = ClientPrefs.keyBinds;
		gamepadBinds = ClientPrefs.gamepadBinds;
	}
}
