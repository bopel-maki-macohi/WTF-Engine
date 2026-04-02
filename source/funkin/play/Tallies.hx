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

	public function combine(tallies:Tallies)
	{
		hits += tallies.hits;
		misses += tallies.misses;

		// Combo should be the highest combo
		combo = Std.int(Math.max(tallies.combo, combo));

		sicks += tallies.sicks;
		goods += tallies.goods;
		bads += tallies.bads;
		shits += tallies.shits;
	}
}
