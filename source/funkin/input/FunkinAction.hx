package funkin.input;

import flixel.input.keyboard.FlxKey;

/**
 * The engine's control action class.
 */
class FunkinAction
{
	var keys:Array<FlxKey> = [];
	var pressed:Bool = false;

	var timestamp(default, null):Int = -1;

	public function new(keys:Array<FlxKey>)
	{
		this.keys = keys;
	}

	public function press()
	{
		if (!pressed)
			timestamp = FlxG.game.ticks;
		pressed = true;
	}

	public function release()
		pressed = false;

	public inline function check():Bool
		return pressed;

	public inline function checkPressed():Bool
		return FlxG.game.ticks - timestamp <= FlxG.elapsed * Constants.MS_PER_SEC;

	public inline function hasKey(key:FlxKey):Bool
		return keys.contains(key);
}
