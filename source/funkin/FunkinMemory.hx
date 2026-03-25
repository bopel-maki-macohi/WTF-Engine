package funkin;

#if cpp
import cpp.vm.Gc;
#end
import openfl.utils.Assets;

/**
 * A class for handling sound and image cache.
 * 
 * For now, its main purpose is clearing the cache.
 */
class FunkinMemory
{
    public static function clearCache()
    {
        Assets.cache.clear();

        // Clear the bitmap cache
        FlxG.bitmap.clearCache();
        
        // Run the garbage collector
        // Major? Pfff I don't know what that means
        #if cpp
        Gc.run(true);
        #end

        trace('Done clearing cache.');
    }
}