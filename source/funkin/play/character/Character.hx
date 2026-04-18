package funkin.play.character;

import funkin.data.character.CharacterData;
import funkin.modding.IScriptedClass.IPlayStateScriptedClass;
import funkin.modding.event.ScriptEvent;
import funkin.play.note.NoteDirection;
import funkin.play.stage.StageProp;

/**
 * A `StageProp` that sings and bops and all that.
 */
class Character extends StageProp implements IPlayStateScriptedClass
{
	public var meta:CharacterData;
	public var isPlayer:Bool;

	// Flixel is so fucking stupid
	// Why does path HAVE to be an already existing variable?!
	public var charPath(get, never):String;

	var singTimer:Float;

	public function buildSprite()
	{
		if (meta == null)
			return;

		// Loads the image
		loadSprite('$charPath/image', meta.scale, meta.width, meta.height);
		loadAnimations(meta.animations);

		bopEvery = meta.bopEvery;

		flipX = meta.flipX != isPlayer;
		flipY = meta.flipY;

		offset.set(-meta.globalOffset[0] ?? 0, -meta.globalOffset[1] ?? 0);

		resetSingTimer();
		bop(true);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		singTimer = Math.min(1, singTimer + elapsed * (Conductor.instance.quaver / 10 / meta.singDuration));
	}

	override public function bop(force:Bool = false)
	{
		if (singTimer < 1 && !force)
			return;
		super.bop(force);
	}

	public function sing(direction:NoteDirection, suffix:String = '')
	{
		if (flipX && direction.horizontal)
			direction = direction.inverse;
		playAnimation('${direction.name}$suffix', true);
	}

	public function miss(direction:NoteDirection, suffix:String = '')
	{
		if (flipX && direction.horizontal)
			direction = direction.inverse;
		playAnimation('${direction.name}-miss$suffix', true);
	}

	public function resetSingTimer()
	{
		singTimer = 0;
	}

	public function buildHealthIcon():HealthIcon
	{
		// Return null if icon data is lacking
		// The god damn errors this would give >:(
		if (meta.icon == null)
			return null;
		return new HealthIcon(id, meta.icon, isPlayer);
	}

	override public function playAnimation(name:String, force:Bool = false)
	{
		super.playAnimation(name, force);

		// Resets the sing timer
		if (!name.startsWith('idle'))
			resetSingTimer();
	}

	inline function get_charPath():String
	{
		return 'play/characters/$id';
	}

	public function onCreate(event:ScriptEvent) {}

	public function onUpdate(event:UpdateScriptEvent) {}

	public function onDestroy(event:ScriptEvent) {}

	public function onNoteHit(event:NoteScriptEvent) {}

	public function onNoteMiss(event:NoteScriptEvent) {}

	public function onHoldNoteHold(event:HoldNoteScriptEvent) {}

	public function onHoldNoteDrop(event:HoldNoteScriptEvent) {}

	public function onGhostMiss(event:GhostMissScriptEvent) {}

	public function onStepHit(event:ConductorScriptEvent) {}

	public function onBeatHit(event:ConductorScriptEvent) {}

	public function onSectionHit(event:ConductorScriptEvent) {}

	public function onSongLoaded(event:SongLoadScriptEvent) {}

	public function onSongStart(event:ScriptEvent) {}

	public function onSongEnd(event:ScriptEvent) {}

	public function onSongRetry(event:ScriptEvent) {}

	public function onSongEvent(event:SongEventScriptEvent) {}

	public function onCountdownStart(event:CountdownScriptEvent) {}

	public function onCountdownStep(event:CountdownScriptEvent) {}

	public function onPause(event:ScriptEvent) {}

	public function onGameOver(event:ScriptEvent) {}
}
