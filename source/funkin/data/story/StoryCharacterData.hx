package funkin.data.story;

import funkin.data.stage.StageData.PropAnimData;

/**
 * A structure object used for story character data.
 */
typedef StoryCharacterData =
{
	var name:String;
	var width:Int;
	var height:Int;
	@:default(1)
	var scale:Float;
	var flipX:Bool;
	var flipY:Bool;
	@:default(2)
	var bopEvery:Int;
	@:default([])
	var animations:Array<PropAnimData>;
}
