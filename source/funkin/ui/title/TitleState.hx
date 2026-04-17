package funkin.ui.title;

import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import funkin.audio.FunkinSound;
import funkin.graphics.FunkinSprite;
import funkin.graphics.FunkinText;
import funkin.ui.menu.MainMenuState;
import funkin.util.MathUtil;

/**
 * The engine's title screen state.
 * This is the very first state the player sees.
 */
class TitleState extends FunkinState
{
	static var seenIntro:Bool = false;

	final SCARE_TIME:Float = 40;

	var started:Bool = false;
	var scared:Bool = false;
	var logoScale:Float;

	var scareTimer:FlxTimer;

	var gfSpooky:FunkinSprite;
	var gfScare:FunkinSprite;
	var gf:FunkinSprite;
	var logo:FunkinSprite;
	var startText:FunkinText;

	override public function create()
	{
		super.create();

		conductor.reset(100);

		gfSpooky = FunkinSprite.create(0, 0, 'ui/title/gf-spooky');
		gfSpooky.screenCenter();
		gfSpooky.active = false;
		gfSpooky.y += 50;
		add(gfSpooky);

		gfScare = FunkinSprite.create(0, 0, 'ui/title/scare/scare');
		gfScare.screenCenter();
		gfScare.active = false;
		gfScare.visible = false;
		gfScare.y -= 50;
		add(gfScare);

		gf = FunkinSprite.create(0, 0, 'ui/title/gf', 1.5, 268, 290);
		gf.x = FlxG.width - gf.width - 30;
		gf.y = FlxG.height - gf.height - 30;
		gf.visible = false;
		gf.addAnimation('idle', [0, 1, 2], 10, false);
		add(gf);

		logo = FunkinSprite.create(60, 60, 'ui/title/logo', 1.75);
		logo.active = false;
		logo.visible = false;
		add(logo);

		startText = new FunkinText(0, 0, 'press accept to begin');
		startText.size = 30;
		startText.screenCenter(X);
		startText.y = FlxG.height - startText.height - 80;
		startText.visible = false;
		add(startText);

		logoScale = logo.scale.x;

		scareTimer = FlxTimer.wait(SCARE_TIME, jumpscare);

		#if HAS_TITLE_SCARE
		if (seenIntro)
			skipIntro();
		else
			FunkinSound.playMusic('ui/music/title-loop');
		#else
		skipIntro();
		#end

		#if HAS_DISCORD_RPC
		DiscordRPC.updatePresence('Title Screen');
		#end
	}

	function skipIntro()
	{
		if (scared)
			return;
		if (!seenIntro)
			FunkinSound.music?.stop();
		seenIntro = true;

		scareTimer.cancel();

		gfSpooky.destroy();
		gfScare.destroy();

		gf.visible = true;
		logo.visible = true;
		startText.visible = true;

		MainMenuState.playMusic();
		FlxG.camera.flash();
	}

	function jumpscare()
	{
		scared = true;

		gfSpooky.destroy();
		gfScare.visible = true;

		FunkinSound.playOnce('ui/title/scare/scare');
		FunkinSound.music.stop();

		FlxTimer.wait(0.5, () -> Sys.exit(0));
	}

	function start()
	{
		if (started)
			return;
		started = true;

		FunkinSound.playOnce('ui/sounds/confirm');
		FlxFlicker.flicker(startText, 1, 0.04, true, true, _ ->
		{
			FlxG.switchState(() -> new MainMenuState());
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		conductor.time = FunkinSound.music.time;
		conductor.update();

		logo.scale.x = MathUtil.lerp(logo.scale.x, logoScale, 0.15);
		logo.scale.y = logo.scale.x;

		if (scared)
		{
			gfScare.scale.x += 20 * elapsed;
			gfScare.scale.y = gfScare.scale.x;
		}

		if (controls.BACK)
		{
			trace('Pressed back. Quitting...');
			Sys.exit(0);
		}

		if (controls.ACCEPT)
		{
			if (seenIntro)
				start();
			else
				skipIntro();
		}
	}

	override function beatHit(beat:Int)
	{
		super.beatHit(beat);

		gf.playAnimation('idle', true);

		// Logo bop
		logo.scale.x = logo.scale.y = logoScale + 0.15;
	}

	override public function destroy()
	{
		super.destroy();

		// This is in case the player pressed F4
		if (!seenIntro)
		{
			seenIntro = true;
			FunkinSound.music.stop();
		}
	}
}
