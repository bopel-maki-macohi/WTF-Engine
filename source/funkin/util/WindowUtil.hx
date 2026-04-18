package funkin.util;

import openfl.Lib;

/**
 * A utility class for handling window-related things.
 */
class WindowUtil
{
	public static function alert(message:String)
	{
		Lib.application.window.alert(message);
	}
}
