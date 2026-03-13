package funkin.play.components;

import funkin.data.character.CharacterData;
import funkin.graphics.FunkinSprite;
import funkin.play.note.NoteDirection;

/**
 * A `FunkinSprite` that sings and bops and all that.
 */
class Character extends FunkinSprite
{
    public var id:String;
    public var meta:CharacterData;
    public var isPlayer:Bool;

    var singTimer:Float;

    public function new(id:String, meta:CharacterData, isPlayer:Bool)
    {
        super();

        this.id = id;
        this.meta = meta;
        this.isPlayer = isPlayer;

        // Loads the image
        var image:String = meta.image ?? id;

        loadSprite('play/characters/$image/image', meta.scale, meta.frameWidth, meta.frameHeight);

        // Adds the animations
        for (anim in meta.animations)
            addAnimation(anim.name, anim.frames, anim.framerate, anim.looped);

        flipX = meta.flipX != isPlayer;

        resetSingTimer();
        dance(true);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        singTimer = Math.min(1, singTimer + elapsed * (Conductor.instance.quaver / 10 / meta.singDuration));
    }

    public function dance(force:Bool = false)
    {
        if ((Conductor.instance.beat % meta.danceEvery == 0 && singTimer == 1) || force)
            playAnimation('idle', true);
    }

    public function sing(direction:NoteDirection)
    {
        playAnimation(direction.name, true);
        resetSingTimer();
    }

    public function miss(direction:NoteDirection)
    {
        playAnimation('${direction.name}-miss', true);
        resetSingTimer();
    }

    public function resetSingTimer()
        singTimer = 0;

    public function buildHealthIcon():HealthIcon
    {
        // Return null if icon data is lacking
        // The god damn errors this would give >:(
        if (meta.icon == null)
            return null;
        return new HealthIcon(id, meta.icon, isPlayer);
    }

    override function set_x(x:Float):Float
        return super.set_x(x + meta?.globalOffset[0] ?? 0);

    override function set_y(y:Float):Float
        return super.set_y(y + meta?.globalOffset[1] ?? 0);
}