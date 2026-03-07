package funkin.graphics;

import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

/**
 * A better version of Flixel's `FlxBar` class because `FlxBar` is dumb and stupid.
 */
class FunkinBar extends FlxSpriteGroup
{
    public var min:Float;
    public var max:Float;
    public var left:Bool;

    public var value(default, set):Float;
    public var percent(get, never):Float;

    var empty:FunkinSprite;
    var fill:FunkinSprite;

    public function new(x:Float, y:Float, width:Int, height:Int, min:Float = 0, max:Float = 100, left:Bool = false)
    {
        super(x, y);

        this.min = min;
        this.max = max;
        this.left = left;

        empty = new FunkinSprite();
        empty.makeSolidColor(width, height, 0xFFFFFFFF);
        empty.active = false;
        add(empty);

        fill = new FunkinSprite();
        fill.makeSolidColor(width, height, 0xFFFFFFFF);
        fill.active = false;
        fill.offset.x = left ? -width : 0;
        fill.origin.x = left ? 1 : 0;
        add(fill);

        value = max;
    }

    public function setColors(emptyColor:FlxColor, fillColor:FlxColor)
    {
        empty.color = emptyColor;
        fill.color = fillColor;
    }

    function set_value(value:Float):Float
    {
        if (this.value == value) return value;
        this.value = value;

        fill.scale.x = percent * (fill.width + 1);

        return value;
    }

    inline function get_percent():Float
        return value / max;
}