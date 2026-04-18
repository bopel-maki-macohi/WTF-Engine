package funkin.play.components;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import funkin.graphics.FunkinSprite;
import funkin.util.RhythmUtil.Judgement;

/**
 * An `FlxGroup` containing popup sprites that appear when hitting notes.
 */
class Popups extends FlxTypedGroup<FunkinSprite>
{
	var style:Style;

	public function new(style:Style)
	{
		super();

		this.style = style;
	}

	function popup(x:Float, y:Float, id:String):FunkinSprite
	{
		var popup:FunkinSprite = recycle(FunkinSprite);

		popup.loadSprite(id, style.scale);

		if (popup.graphic == null)
		{
			popup.kill();
			return popup;
		}

		popup.setPosition(x, y);
		popup.acceleration.y = 450;
		popup.moves = true;

		popup.velocity.y = -200 - FlxG.random.int(0, 30);
		popup.alpha = 1;

		FlxTimer.wait(0.25, () ->
		{
			FlxTween.tween(popup, {alpha: 0}, 0.6, {ease: FlxEase.quadOut, onComplete: _ -> popup.kill()});
		});

		// Ensure that the sprite is on top
		popup.zIndex = getLast(last -> last.zIndex > popup.zIndex)?.zIndex + 1;

		refresh();

		return popup;
	}

	public function popupJudgement(id:Judgement)
	{
		popup(80, 40, style.getJudgement(id));
	}

	public function popupCombo(combo:Int)
	{
		// Don't show a combo that's less than 10
		if (combo < 10)
			return;

		var comboStr:String = Std.string(combo);
		var numbers:Array<String> = comboStr.split('');

		for (i => number in numbers)
		{
			var number:Int = Std.parseInt(number);
			var sprite:FunkinSprite = popup(120, 90, style.getComboNumber(number));
			sprite.x += sprite.width * 0.85 * i;
		}
	}
}
