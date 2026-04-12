package funkin.data.stage;

import funkin.data.character.CharacterData.CharacterAnimData;

/**
 * A structure object used for stage data.
 */
typedef StageData =
{
	var name:String;
	@:optional
	var zoom:Float;
	var opponent:StageCharacterData;
	var player:StageCharacterData;
	var gf:StageCharacterData;
	@:default([])
	var props:Array<StagePropData>;
}

/**
 * A structure object used for stage character data.
 */
typedef StageCharacterData =
{
	var position:Array<Float>;
	var scroll:Array<Float>;
	@:optional
	var zIndex:Int;
}

/**
 * A structure object used for stage prop data.
 */
typedef StagePropData =
{
	@:optional
	var id:String;
	@:optional
	var prop:String;
	var image:String;
	var frameWidth:Int;
	var frameHeight:Int;
	var position:Array<Float>;
	var scroll:Array<Float>;
	@:default(1)
	var scale:Float;
	var flipX:Bool;
	var flipY:Bool;
	var zIndex:Int;
	@:default([])
	var animations:Array<CharacterAnimData>;
}
