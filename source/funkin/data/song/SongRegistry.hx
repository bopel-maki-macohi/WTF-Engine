package funkin.data.song;

import funkin.data.song.SongData;
import funkin.data.story.LevelRegistry;
import funkin.modding.ScriptBases.ScriptedSong;
import funkin.play.song.Song;
import funkin.ui.story.Level;
import funkin.util.FileUtil;
import json2object.JsonParser;

/**
 * A registry class for loading songs.
 */
class SongRegistry extends BaseRegistry<Song>
{
	public static var instance:SongRegistry;

	var metaParser(default, null) = new JsonParser<SongMetadata>();
	var chartParser(default, null) = new JsonParser<SongChartData>();

	var diffs:Array<String>;

	public function new()
	{
		super('songs', 'play/songs');
	}

	override public function load()
	{
		super.load();

		//
		// VANILLA
		//

		for (id in FileUtil.listFolders(path))
		{
			final metaPath:String = Paths.json('$path/$id/meta');
			final chartPath:String = Paths.json('$path/$id/chart');

			// Skip the song if it doesn't have a chart or metadata file
			if (!Paths.exists(metaPath) || !Paths.exists(chartPath))
				continue;

			var song:Song = new Song(id);

			song.meta = metaParser.fromJson(FileUtil.getText(metaPath));
			song.chart = chartParser.fromJson(FileUtil.getText(chartPath));

			register(id, song);

			// Checks for variations
			for (variation in FileUtil.listFolders('$path/$id'))
			{
				final metaPath:String = Paths.json('$path/$id/$variation/meta');
				final chartPath:String = Paths.json('$path/$id/$variation/chart');

				// Skip the variation if it doesn't have a chart or metadata file
				if (!Paths.exists(metaPath) || !Paths.exists(chartPath))
					continue;

				var songVariation:Song = new Song(id);

				song.variations.set(variation, songVariation);

				songVariation.meta = metaParser.fromJson(FileUtil.getText(metaPath));
				songVariation.chart = chartParser.fromJson(FileUtil.getText(chartPath));
				songVariation.variation = variation;
			}
		}

		//
		// SCRIPTED
		//

		var scripts:Array<String> = ScriptedSong.listScriptClasses();

		trace('Loading ${scripts.length} scripted song(s)...');

		for (script in scripts)
		{
			try
			{
				var song:Song = ScriptedSong.scriptInit(script, '');
				var ogSong:Song = fetch(song.id);

				song.meta = ogSong.meta;
				song.chart = ogSong.chart;
				song.variations = ogSong.variations;

				entries.set(song.id, song);
			}
			catch (e)
				trace('Failed to load script $script.');
		}
	}

	public function getDifficulties():Array<String>
	{
		// Use a cached array to make it real easy for the engine
		if (diffs != null)
			return diffs;

		diffs = [];

		for (song in entries)
		{
			for (diff in song.getDifficulties())
			{
				// Skip the difficulty if it's already in the list
				if (diffs.contains(diff))
					continue;
				diffs.push(diff);
			}
		}

		return diffs;
	}

	public function listWithDifficulty(diff:String):Array<String>
	{
		var list:Array<String> = [];

		// List songs through levels to ensure proper order
		for (id in LevelRegistry.instance.listSorted())
		{
			var level:Level = LevelRegistry.instance.fetch(id);

			for (id in level.getSongs())
			{
				var song:Song = SongRegistry.instance.fetch(id);

				if (list.contains(id) || !song.hasDifficulty(diff))
					continue;
				list.push(id);
			}
		}

		// List songs through the entries themselves
		// Because not every song has a level
		for (id => song in entries)
		{
			if (list.contains(id) || !song.difficulties.contains(diff))
				continue;
			list.push(id);
		}

		return list;
	}
}
