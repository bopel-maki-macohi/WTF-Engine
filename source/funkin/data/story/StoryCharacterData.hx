package funkin.data.story;

import funkin.data.character.CharacterData.CharacterAnimData;

/**
 * A structure object used for story character data.
 */
typedef StoryCharacterData =
{
	var name:String;
	var frameWidth:Int;
	var frameHeight:Int;
	@:default(1)
	var scale:Float;
	var flipX:Bool;
	var flipY:Bool;
	@:default(2)
	var danceEvery:Int;
	@:default([])
	var animations:Array<CharacterAnimData>;
}
