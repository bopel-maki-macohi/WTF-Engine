package funkin.play.song;

import funkin.audio.FunkinSound;

/**
 * The game's vocal group, containing both the opponent and player's voices.
 */
class Voices
{
	public var opponent:FunkinSound;
	public var player:FunkinSound;

	public var opponentVolume(get, set):Float;
	public var playerVolume(get, set):Float;

	public function new(song:Song)
	{
		opponent = FunkinSound.load(song.opponentPath, 1, false, false, false);
		player = FunkinSound.load(song.playerPath, 1, false, false, false);
	}

	public function play()
	{
		opponent.play();
		player.play();
	}

	public function pause()
	{
		opponent.pause();
		player.pause();
	}

	public function stop()
	{
		opponent.stop();
		player.stop();
	}

	public function checkResync(time:Float)
	{
		// Opponent vocals resync
		if (Math.abs(time - opponent.time) > Constants.RESYNC_THRESHOLD && opponent.playing)
		{
			opponent.pause();
			opponent.time = time;
			opponent.play();
		}

		// Player vocals resync
		if (Math.abs(time - player.time) > Constants.RESYNC_THRESHOLD && player.playing)
		{
			player.pause();
			player.time = time;
			player.play();
		}
	}

	function set_opponentVolume(volume:Float):Float
	{
		opponent.volume = opponentVolume;
		return opponentVolume;
	}

	function set_playerVolume(playerVolume:Float):Float
	{
		player.volume = playerVolume;
		return playerVolume;
	}

	inline function get_opponentVolume():Float
		return opponent.volume;

	inline function get_playerVolume():Float
		return player.volume;
}
