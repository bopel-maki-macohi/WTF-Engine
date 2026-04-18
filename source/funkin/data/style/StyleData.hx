package funkin.data.style;

import funkin.data.stage.StageData.PropAnimData;

/**
 * A structure object used for style data.
 */
typedef StyleData =
{
	var name:String;
	var artist:String;
	var note:StyleNoteData;
	var noteSplash:StyleNoteData;
	var holdCover:StyleNoteData;
	@:default(1)
	var scale:Float;
}

/**
 * A structure object used for style note data.
 */
typedef StyleNoteData =
{
	var width:Int;
	var height:Int;
	@:default(1)
	var scale:Float;
	@:default(10)
	var framerate:Int;
	var animations:StyleAnimData;
}

/**
 * A structure object used for style note animation data.
 */
typedef StyleAnimData =
{
	@:default([])
	var left:Array<Int>;
	@:default([])
	var down:Array<Int>;
	@:default([])
	var up:Array<Int>;
	@:default([])
	var right:Array<Int>;
}
