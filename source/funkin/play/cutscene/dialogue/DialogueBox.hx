package funkin.play.cutscene.dialogue;

import flixel.math.FlxPoint;
import funkin.data.dialogue.DialogueBoxData;
import funkin.graphics.FunkinSprite;
import funkin.util.FileUtil;
import funkin.util.MathUtil;
import json2object.JsonParser;

/**
 * The box sprite used for the `DialogueCutscene` class.
 */
class DialogueBox extends FunkinSprite
{
	static var parser(default, null) = new JsonParser<DialogueBoxData>();

	public var speakerOffset:FlxPoint;
	public var textOffset:FlxPoint;

	public function new(id:String)
	{
		super();

		final path:String = 'play/dialogue/boxes/$id';
		final metaPath:String = Paths.json('$path/meta');

		// Can't load the metadata if it doesn't exist
		if (!Paths.exists(metaPath))
			return;

		var meta:DialogueBoxData = parser.fromJson(FileUtil.getText(metaPath));

		speakerOffset = MathUtil.arrayToPoint(meta.speakerOffset);
		textOffset = MathUtil.arrayToPoint(meta.textOffset);

		loadSprite('$path/image', meta.scale, meta.width, meta.height);

		addAnimation('start', [0, 1, 2], 10, false);
		playAnimation('start');
	}

	override public function destroy()
	{
		super.destroy();

		// Add these points back into the pool
		speakerOffset.put();
		textOffset.put();
	}
}
