package funkin.util.tools;

/**
 * A tools class for handling iterators.
 * Kinda stole this from Funkin' lol.
 */
class IteratorTools
{
	public static function array<T>(iterator:Iterator<T>):Array<T>
		return [for (i in iterator) i];
}
