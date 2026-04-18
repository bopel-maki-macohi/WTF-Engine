package funkin.data.dialogue;

/**
 * A structure object used for dialogue box data.
 */
typedef DialogueBoxData =
{
	var width:Int;
	var height:Int;
	@:default(1)
	var scale:Float;
	var speakerOffset:Array<Float>;
	var textOffset:Array<Float>;
}
