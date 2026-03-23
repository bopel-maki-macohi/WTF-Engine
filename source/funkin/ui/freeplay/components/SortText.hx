package funkin.ui.freeplay.components;

import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSignal.FlxTypedSignal;
import flixel.util.FlxTimer;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.graphics.FunkinText;
import funkin.input.Controls;

/**
 * Text that displays how freeplay songs are currently being sorted.
 */
class SortText extends FlxSpriteGroup
{
    final ARROW_SPACING:Float = 10;
    final MAX_SORTS:Int = 2;

    public var selected:Int;
    public var busy:Bool = false;

    public var onSelected(default, null) = new FlxTypedSignal<Int->Void>();

    var sortText:FunkinText;
    var arrowLeft:FunkinSprite;
    var arrowRight:FunkinSprite;
    
    var selectTimer:FlxTimer;

    public function new(selected:Int = 0)
    {
        super();
        
        this.selected = selected;

        sortText = new FunkinText();
        add(sortText);

        arrowLeft = FunkinSprite.create(0, 0, 'ui/freeplay/sort-arrow');
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

        var left:Bool = Controls.instance.SORT_LEFT;
        var right:Bool = Controls.instance.SORT_RIGHT;

        if (left || right)
            select(left ? -1 : 1);
    }

    function select(change:Int = 0)
    {
        final lastSelected:Int = selected;

        selected += change;

        if (selected < 0)
            selected = MAX_SORTS - 1;
        else if (selected >= MAX_SORTS)
            selected = 0;

        switch (selected)
        {
            case 1:
                sortText.text = 'favorites';
            default:
                sortText.text = 'all';
        }

        sortText.x = arrowLeft.x + arrowLeft.width + ARROW_SPACING;
        
        arrowRight.x = sortText.x + sortText.width + ARROW_SPACING;
        arrowLeft.y = sortText.y + (sortText.height - arrowLeft.height) / 2;
        arrowRight.y = arrowLeft.y;

        if (lastSelected != selected && change != 0)
        {
            FunkinSound.playOnce('ui/sounds/scroll');

            sortText.y -= 5;

            selectTimer?.cancel();
            selectTimer = FlxTimer.wait(0.05, () -> sortText.y += 5);

            onSelected.dispatch(selected);
        }
    }
}