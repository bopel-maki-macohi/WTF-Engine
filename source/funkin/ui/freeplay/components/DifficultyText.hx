package funkin.ui.freeplay.components;

import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSignal.FlxTypedSignal;
import flixel.util.FlxTimer;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.graphics.FunkinText;
import funkin.input.Controls;

/**
 * Text that displays the current difficulty in the freeplay menu.
 */
class DifficultyText extends FlxSpriteGroup
{
    final ARROW_SPACING:Float = 10;
    
    public var selected:Int;
    public var difficulties:Array<String>;
    public var difficulty(get, never):String;

    public var busy:Bool = false;

    public var onSelected(default, null) = new FlxTypedSignal<Int->Void>();

    var diffText:FunkinText;
    var arrowLeft:FunkinSprite;
    var arrowRight:FunkinSprite;
    
    var selectTimer:FlxTimer;

    public function new(selected:Int = 0, difficulties:Array<String>)
    {
        super();

        this.selected = selected;
        this.difficulties = difficulties;

        diffText = new FunkinText();
        diffText.size = 48;
        add(diffText);

        arrowLeft = FunkinSprite.create(0, 0, 'ui/freeplay/arrow');
        arrowLeft.active = false;
        add(arrowLeft);

        arrowRight = new FunkinSprite();
        arrowRight.loadGraphicFromSprite(arrowLeft);
        arrowRight.setGraphicSize(arrowLeft.width, arrowLeft.height);
        arrowRight.updateHitbox();
        arrowRight.flipX = true;
        arrowRight.active = false;
        add(arrowRight);

        select();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (busy) return;

        var left:Bool = Controls.instance.UI_LEFT_P;
        var right:Bool = Controls.instance.UI_RIGHT_P;

        if (left || right)
            select(left ? -1 : 1);
    }

    function select(change:Int = 0)
    {
        final lastSelected:Int = selected;

        selected += change;

        if (selected < 0)
            selected = difficulties.length - 1;
        else if (selected >= difficulties.length)
            selected = 0;

        diffText.text = difficulty;
        diffText.x = arrowLeft.x + arrowLeft.width + ARROW_SPACING;
        
        arrowRight.x = diffText.x + diffText.width + ARROW_SPACING;
        arrowLeft.y = diffText.y + (diffText.height - arrowLeft.height) / 2;
        arrowRight.y = arrowLeft.y;

        if (lastSelected != selected && change != 0)
        {
            FunkinSound.playOnce('ui/sounds/scroll');

            diffText.y -= 5;

            selectTimer?.cancel();
            selectTimer = FlxTimer.wait(0.05, () -> diffText.y += 5);

            onSelected.dispatch(selected);
        }
    }

    inline function get_difficulty():String
        return difficulties[selected];
}