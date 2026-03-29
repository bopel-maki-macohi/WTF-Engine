package funkin.ui.menu;

import flixel.FlxObject;
import flixel.util.FlxTimer;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.graphics.FunkinText;
import funkin.ui.freeplay.FreeplaySubState;
import funkin.ui.story.StoryMenuSubState;

/**
 * The engine's main menu state.
 * This is the menu where the player can access the story and freeplay menu.
 */
class MainMenuState extends FunkinState
{
    static var selectedItem:Int = 0;

    var stateMachine:StateMachine;

    var camFollow:FlxObject;
    var items:MenuItemGroup;

    override public function create()
    {
        super.create();

        FunkinSound.playMusic('ui/music/menu');

        stateMachine = new StateMachine();

        camFollow = new FlxObject();
        camFollow.active = false;
        camFollow.screenCenter();
        FlxG.camera.follow(camFollow, LOCKON, 0.06);

        var bg:FunkinSprite = FunkinSprite.create(0, 0, 'ui/menu/bg', 1.5);
        bg.scale.add(0.15, 0.15);
        bg.color = 0xFFFFC82F;
        bg.active = false;
        bg.scrollFactor.set(0, 0.1);
        add(bg);

        var version:FunkinText = new FunkinText(10, 0, '${Constants.TITLE} ${Constants.VERSION}');
        version.size = 15;
        version.y = FlxG.height - version.height - 10;
        version.scrollFactor.set();
        add(version);

        items = new MenuItemGroup(selectedItem);
        items.onChanged.add(change);
        items.addItem('story', () -> openSubState(new StoryMenuSubState()));
        items.addItem('freeplay', () -> openSubState(new FreeplaySubState()));
        add(items);

        change(selectedItem);

        FlxG.camera.snapToTarget();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (controls.ACCEPT)
            confirm();

        items.busy = !stateMachine.canInteract();
    }

    function change(selected:Int)
    {
        selectedItem = selected;

        // Positions the camera
        camFollow.y = items.item.y;
    }

    function confirm()
    {
        if (!stateMachine.canInteract()) return;
        stateMachine.transition(Interacting);

        items.flicker();

        FunkinSound.playOnce('ui/sounds/confirm');
        FlxTimer.wait(1, stateMachine.reset);
    }
}