package funkin.play;

import flixel.sound.FlxSound;
import flixel.util.FlxTimer;
import funkin.audio.FunkinSound;
import funkin.data.character.CharacterRegistry;
import funkin.play.character.Character;
import funkin.ui.FunkinSubState;

/**
 * The game over sub state that appears when the player dies.
 */
class GameOverSubState extends FunkinSubState
{
	var skipped:Bool = false;

	var menuConductor:Conductor;

	var music:FlxSound;
	var startSound:FlxSound;

	var player:Character;
	var character:Character;
	var id:String;

	override public function create()
	{
		super.create();

		PlayState.instance.deaths++;

		_parentState.persistentDraw = false;

		menuConductor = new Conductor();
		menuConductor.beatHit.add(beatHit);
		menuConductor.reset(100);

		player = PlayState.instance.stage.player;
		id = player.meta.death ?? player?.id ?? 'bf';

		buildCharacter();

		music = FunkinSound.load(getPath('music'), 1, true, true, false);

		startSound = FunkinSound.load(getPath('start'), 1, false);
		startSound.onComplete = () -> music.play();

		if (character != null)
		{
			PlayState.instance.setCameraTarget(character);
			FlxG.camera.active = true;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Updates the conductor
		menuConductor.time = music?.time;
		menuConductor.update();

		if (controls.ACCEPT)
			skip();
		if (controls.BACK)
			PlayState.instance.exit();
	}

	function buildCharacter()
	{
		character = CharacterRegistry.instance.fetchCharacter('$id-death');

		// Don't do the actual character stuff if it's null
		// Because I guess you never know when the death sprite doesn't exist
		if (character == null)
			return;

		character.scrollFactor.copyFrom(player.scrollFactor);
		character.setPosition(player.x, player.y);
		character.playAnimation('start');
		add(character);
	}

	function getPath(id:String):String
	{
		return '${character?.charPath}/$id';
	}

	function skip()
	{
		if (skipped)
			return;
		skipped = true;

		character?.playAnimation('end');

		music.destroy();
		startSound.destroy();

		// Gotta reset this!
		// Or else the character keeps bopping
		menuConductor.reset();

		FunkinSound.playOnce(getPath('end'));
		FlxTimer.wait(1, () -> FlxG.camera.fade(0xFF000000, 2, false, close));
	}

	override function beatHit(beat:Int)
	{
		super.beatHit(beat);

		character?.playAnimation('loop', true);

		// We still want the beat hit script event to work
		// So we're doing this >:)
		@:privateAccess
		PlayState.instance.beatHit(beat);
	}

	override public function close()
	{
		super.close();

		_parentState.persistentDraw = true;

		FlxG.camera.fade(0xFF000000, 1, true);

		PlayState.instance.resetSong();
	}
}
