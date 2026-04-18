package funkin.play.cutscene.dialogue;

import flixel.math.FlxPoint;
import funkin.data.dialogue.DialogueSpeakerData;
import funkin.graphics.FunkinSprite;
import funkin.util.FileUtil;
import funkin.util.MathUtil;
import json2object.JsonParser;

/**
 * A `FunkinSprite` used as the speaker for the `DialogueCutscene` class.
 */
class DialogueSpeaker extends FunkinSprite
{
	static var parser(default, null) = new JsonParser<DialogueSpeakerData>();

	public var right:Bool = false;

	public function new()
	{
		super();

		active = false;
	}

	public function load(id:String)
	{
		final path:String = 'play/dialogue/speakers/$id';
		final metaPath:String = Paths.json('$path/meta');

		// Hide the speaker if it doesn't exist
		// This would be good for narration
		if (!Paths.exists(metaPath))
		{
			visible = false;
			return;
		}

		var meta:DialogueSpeakerData = parser.fromJson(FileUtil.getText(metaPath));
		var off:FlxPoint = MathUtil.arrayToPoint(meta.offset);

		loadSprite('$path/image', meta.scale);
		centerOffsets();

		right = meta.right;

		offset.add(off.x, off.y);
		visible = graphic != null;

		// We're done with the offset point
		// Why not add it back to the pool
		off.put();
	}
}
