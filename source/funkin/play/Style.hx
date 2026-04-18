package funkin.play;

import funkin.data.style.StyleData;
import funkin.play.note.NoteDirection;
import funkin.util.RhythmUtil.Judgement;

/**
 * The note style class that gives the gameplay its lovely appearance.
 */
class Style
{
	public var id:String;
	public var meta:StyleData;

	public var name(get, never):String;
	public var artist(get, never):String;
	public var scale(get, never):Float;
	public var note(get, never):StyleNoteData;
	public var noteSplash(get, never):StyleNoteData;
	public var holdCover(get, never):StyleNoteData;

	public var path(get, never):String;

	public function new(id:String)
	{
		this.id = id;
	}

	public function getPath(id:String):String
	{
		return '$path/$id';
	}

	public function getCountdown(id:String):String
	{
		return getPath('countdown/$id');
	}

	public function getJudgement(judgement:Judgement):String
	{
		return getPath('judgement/$judgement');
	}

	public function getComboNumber(number:Int):String
	{
		return getPath('combo/num$number');
	}

	public function getNoteFrames(data:StyleAnimData, direction:NoteDirection):Array<Int>
	{
		return Reflect.field(data, direction.name);
	}

	function get_name():String
	{
		var name:String = meta.name;
		if (name.isEmpty())
			name = Constants.DEFAULT_NAME;
		return name;
	}

	function get_artist():String
	{
		var artist:String = meta.artist;
		if (artist.isEmpty())
			artist = Constants.DEFAULT_ARTIST;
		return artist;
	}

	function get_scale():Float
	{
		return meta.scale;
	}

	function get_note():StyleNoteData
	{
		return meta.note;
	}

	function get_noteSplash():StyleNoteData
	{
		return meta.noteSplash;
	}

	function get_holdCover():StyleNoteData
	{
		return meta.holdCover;
	}

	inline function get_path():String
	{
		return 'play/styles/$id';
	}

	public function toString():String
	{
		return '$id | $name';
	}
}
