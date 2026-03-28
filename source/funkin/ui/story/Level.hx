package funkin.ui.story;

import funkin.data.song.SongRegistry;
import funkin.data.story.LevelData;
import funkin.play.song.Song;

/**
 * A class containing the metadata for a level.
 */
class Level
{
    public var id:String;
    public var meta:LevelData;

    public var name(get, never):String;
    public var title(get, never):String;

    public var opponent(get, never):String;
    public var player(get, never):String;
    public var gf(get, never):String;

    var songs:Array<String>;
    var songNames:Array<String>;

    public function new(id:String, meta:LevelData)
    {
        this.id = id;
        this.meta = meta;
    }

    public function getSongs():Array<String>
    {
        // Use a cached array to make it real easy for the engine
        if (songs != null) return songs;

        songs = [];

        for (song in meta.songs)
        {
            // Skip duplicate songs
            if (songs.contains(song)) continue;

            // Push the song if it exists
            // There's no point of keeping null songs
            if (SongRegistry.instance.exists(song))
                songs.push(song);
        }

        return songs;
    }

    public function getSongNames():Array<String>
    {
        // Use a cached array to make it real easy for the engine
        if (songNames != null) return songNames;

        songNames = [];

        for (song in getSongs())
        {
            var song:Song = SongRegistry.instance.fetch(song);
            var name:String = song.name;

            songNames.push(name);
        }

        return songNames;
    }

    public function hasSong(id:String):Bool
        return getSongs().contains(id);

    inline function get_name():String
    {
        var name:Null<String> = meta.name;
        if (name.isEmpty())
            name = Constants.DEFAULT_NAME;
        return name;
    }

    inline function get_title():String
        return meta.title ?? id;

    inline function get_opponent():String
        return meta.opponent;

    inline function get_player():String
        return meta.player;

    inline function get_gf():String
        return meta.gf;
}