package funkin;

#if HAS_DISCORD_RPC
import cpp.ConstCharStar;
import cpp.Function;
import cpp.RawConstPointer;
import cpp.RawPointer;
import hxdiscord_rpc.Discord;
import hxdiscord_rpc.Types.DiscordEventHandlers;
import hxdiscord_rpc.Types.DiscordRichPresence;
import hxdiscord_rpc.Types.DiscordUser;
import openfl.Lib;
import sys.thread.Thread;

/**
 * A class for handling the Discord Rich Presence.
 */
class DiscordRPC
{
	static final APP_ID:String = '1494506209036992636';

	static var handlers:DiscordEventHandlers;
	static var presence:DiscordRichPresence;

	public static function init()
	{
		trace('Initializing Discord RPC...');

		handlers = new DiscordEventHandlers();
		handlers.ready = Function.fromStaticFunction(ready);
		handlers.errored = Function.fromStaticFunction(error);
		handlers.disconnected = Function.fromStaticFunction(disconnect);

		Discord.Initialize(APP_ID, RawPointer.addressOf(handlers), false, null);

		// Creates the daemon thread
		// This allows Discord to update and run its stuff
		Thread.create(() ->
		{
			while (true)
			{
				#if DISCORD_DISABLE_IO_THREAD
				Discord.UpdateConnection();
				#end
				Discord.RunCallbacks();
				Sys.sleep(2);
			}
		});

		// Shutdown Discord RPC once the game is closed
		// Can't keep it active forever
		Lib.application.onExit.add(shutdown);
	}

	public static function updatePresence(state:String = '', details:String = '')
	{
		presence.state = state;
		presence.details = details;

		Discord.UpdatePresence(RawPointer.addressOf(presence));
	}

	static function shutdown(code:Int)
	{
		trace('Shutting down Discord RPC...');

		Discord.Shutdown();
	}

	static function ready(request:RawConstPointer<DiscordUser>)
	{
		trace('Done initializing Discord RPC.');
		trace('Haiii!! ${request[0].username}!');

		presence = new DiscordRichPresence();
		presence.type = DiscordActivityType_Playing;
	}

	static function error(code:Int, message:ConstCharStar)
	{
		trace('Error ($code:$message).');
	}

	static function disconnect(code:Int, message:ConstCharStar)
	{
		trace('Disconnected ($code:$message).');
	}
}
#end
