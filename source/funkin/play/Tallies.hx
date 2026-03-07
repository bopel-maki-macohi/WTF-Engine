package funkin.play;

/**
 * A class for keeping track of the game's tallies (sicks, misses, combo, etc.).
 */
class Tallies
{
    public var hits:Int;
    public var misses:Int;
    public var combo:Int;

    public var sicks:Int;
    public var goods:Int;
    public var bads:Int;
    public var shits:Int;

    public function new() {}

    public function reset()
    {
        hits = 0;
        misses = 0;
        combo = 0;

        sicks = 0;
        goods = 0;
        bads = 0;
        shits = 0;
    }
}