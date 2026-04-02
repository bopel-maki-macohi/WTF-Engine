package funkin.audio;

import flixel.sound.FlxSound;

/**
 * A class for playing and handling sounds.
 */
class FunkinSound extends FlxSound
{
	public static var music:FunkinSound;

	public static function load(id:String, volume:Float = 1, looped:Bool = true, autoDestroy:Bool = true, autoPlay:Bool = true):FunkinSound
	{
		var sound:FunkinSound = cast FlxG.sound.list.recycle(FunkinSound);

		sound.loadEmbedded(Paths.sound(id), looped, autoDestroy);
		sound.persist = false;
		sound.volume = volume;

		FlxG.sound.list.add(sound);
		FlxG.sound.defaultSoundGroup.add(sound);

		if (autoPlay)
			sound.play();

		return sound;
	}

	public static function playOnce(id:String, volume:Float = 1):FunkinSound
		return load(id, volume, false);

	public static function playMusic(id:String, volume:Float = 1, looped:Bool = true, autoPlay:Bool = true, overrideMusic:Bool = true)
	{
		if (music?.playing && !overrideMusic)
			return;

		if (music == null)
			music = new FunkinSound();
		else if (music.active)
			music.stop();

		music.loadEmbedded(Paths.sound(id), looped);
		music.volume = volume;
		music.persist = true;

		FlxG.sound.music = music;
		FlxG.sound.defaultMusicGroup.add(music);

		if (autoPlay)
			music.play();
	}

	public static function stopAllSounds(stopMusic:Bool = false)
	{
		for (sound in FlxG.sound.list)
			sound.stop();
		if (stopMusic)
			music?.stop();
	}
}
