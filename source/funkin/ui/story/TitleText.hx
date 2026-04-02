package funkin.ui.story;

import flixel.util.FlxTimer;
import funkin.graphics.FunkinText;

class TitleText extends FunkinText
{
	public function flicker()
	{
		FlxTimer.loop(0.04, loop ->
		{
			if (loop % 2 == 0)
				color = 0xFFFFFFFF;
			else
				color = 0xFF00FFFF;
		}, 0);
	}
}
