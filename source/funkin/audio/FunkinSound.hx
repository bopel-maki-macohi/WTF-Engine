package funkin.audio;

import flixel.FlxG;
import flixel.sound.FlxSound;

/**
 * A helper class for handling the engine's audio.
 */
class FunkinSound
{
	public static var music(get, never):FlxSound;

	public static inline function load(id:String, volume:Float = 1, looped:Bool = true, autoDestroy:Bool = true, autoPlay:Bool = true):FlxSound
	{
		var sound:FlxSound = FlxG.sound.create(Paths.sound(id));

		sound.setup(volume, -1, autoDestroy);
		sound.looped = looped;

		if (autoPlay)
			sound.play();

		return sound;
	}

	public static inline function playOnce(id:String, volume:Float = 1):FlxSound
	{
		return FlxG.sound.play(Paths.sound(id), volume);
	}

	public static inline function playMusic(id:String, volume:Float = 1, looped:Bool = true, autoPlay:Bool = true, overrideMusic:Bool = true)
	{
		if (music?.playing && !overrideMusic)
			return;

		FlxG.sound.playMusic(Paths.sound(id), null, volume, looped);

		music.persist = true;

		if (!autoPlay)
			music.stop();
	}

	public static function stopAllSounds(stopMusic:Bool = false)
	{
		FlxG.sound.list.forEachAlive(sound ->
		{
			if (sound == music && !stopMusic)
				return;
			sound.stop();
		});
	}

	static inline function get_music():FlxSound
	{
		return FlxG.sound.music;
	}
}
