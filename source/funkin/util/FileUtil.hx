package funkin.util;

import openfl.utils.Assets;

/**
 * A utility class for file handling.
 */
class FileUtil
{
	public static function getText(id:String):String
		return try
		{
			Assets.getText(id);
		}
		catch (e)
			'';

	public static function listFolders(id:String):Array<String>
	{
		id = Paths.path(id);

		var list:Array<String> = [];
		var items:Array<String> = Assets.list().filter(item -> return item.startsWith(id));

		for (item in items)
		{
			item = item.substr(0, item.lastIndexOf('/'));
			item = item.substr(item.lastIndexOf('/') + 1);

			if (list.contains(item))
				continue;

			list.push(item);
		}

		return list;
	}
}
