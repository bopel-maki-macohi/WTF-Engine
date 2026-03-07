package funkin.graphics;

import flixel.group.FlxSpriteGroup;

/**
 * A better version of Flixel's `FlxBar` class because `FlxBar` is dumb and stupid.
 * 
 * TODO: Allow the colors to be changed.
 */
class FunkinBar extends FlxSpriteGroup
{
    public var min:Float;
    public var max:Float;
    public var left:Bool;

    public var value(default, set):Float;

    var empty:FunkinSprite;
    var fill:FunkinSprite;

    public function new(x:Float, y:Float, width:Int, height:Int, min:Float = 0, max:Float = 100, left:Bool = false)
    {
        super(x, y);

        this.min = min;
        this.max = max;
        this.left = left;

        empty = new FunkinSprite();
        empty.makeGraphic(width, height, 0xFFFF0000);
        empty.active = false;
        add(empty);

        fill = new FunkinSprite();
        fill.makeGraphic(width, height, 0xFF00FF00);
        fill.active = false;
        fill.origin.x = left ? fill.width : 0;
        add(fill);

        value = min;
    }

    function set_value(value:Float):Float
    {
        if (this.value == value) return value;
        this.value = value;

        fill.scale.x = value / max;

        return value;
    }
}