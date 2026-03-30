package funkin.modding;

import funkin.data.character.CharacterRegistry;
import funkin.data.event.EventRegistry;
import funkin.data.song.SongRegistry;
import funkin.data.stage.StageRegistry;
import funkin.data.story.LevelRegistry;
import polymod.Polymod;
import sys.FileSystem;

/**
 * A class for handling the engine's mod support.
 */
class ModHandler
{
    static final MOD_FOLDER:String = 'mods';
    static final CORE_FOLDER:String = 'assets';

    static final API_VERSION_RULE:String = '>=0.1.0';

    public static function init()
    {
        // Creates the mod folder
        if (!FileSystem.exists(MOD_FOLDER))
            FileSystem.createDirectory(MOD_FOLDER);

        // Initializes Polymod
        Polymod.init({
            modRoot: MOD_FOLDER,
            dirs: [],
            framework: OPENFL,
            errorCallback: onError,
            apiVersionRule: API_VERSION_RULE,
            skipDependencyErrors: true,
            useScriptedClasses: true
        });

        #if HAS_MODDING
        for (meta in Polymod.scan())
            Polymod.loadMod(meta.dirName);
        #end
    }

    public static function reload()
    {
        Polymod.clearCache();
        Polymod.clearScripts();

        Polymod.reload();

        // Reloads the registries
        // Not having this would ruin the point of hot-reloading
        CharacterRegistry.instance.load();
		StageRegistry.instance.load();
		SongRegistry.instance.load();
		LevelRegistry.instance.load();
		EventRegistry.instance.load();
    }

    static function onError(e:PolymodError)
    {
        // Don't trace errors related to framework or missing icons
        // Literally no one cares
        if (e.code == FRAMEWORK_INIT || e.code == MOD_MISSING_ICON) return;

        trace(e.message);
    }
}