package funkin.ui.menu;

import funkin.graphics.FunkinSprite;

/**
 * A `FunkinSprite` used for main menu navigation.
 */
class MenuItem extends FunkinSprite
{
    public var id:String;
    public var selected(default, set):Bool;

    public var onSelected:Void->Void;

    public function new(id:String)
    {
        super();

        this.id = id;

        // Loads the sprite
        // Loads it twice to properly get the frame size
        final image:String = 'ui/menu/items/$id';

        loadSprite(image);

        var width:Int = graphic.width;
        var height:Int = Std.int(graphic.height / 2);

        loadSprite(image, 1.25, width, height);
        addAnimation('idle', [0]);
        addAnimation('select', [1]);

        scrollFactor.set(0, 0.2);

        selected = false;
        active = false;
    }

    function set_selected(selected:Bool):Bool
    {
        if (this.selected == selected) return selected;
        this.selected = selected;

        playAnimation(selected ? 'select' : 'idle');

        return selected;
    }
}