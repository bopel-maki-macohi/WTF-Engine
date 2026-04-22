package funkin.modding.event;

/**
 * An enum of the different script event types.
 */
enum ScriptEventType
{
	// Basic
	Create;
	Update;
	Destroy;

	// Note
	NoteHit;
	NoteMiss;
	HoldNoteHold;
	HoldNoteDrop;
	GhostMiss;

	// Conductor
	StepHit;
	BeatHit;

	// PlayState
	SongLoad;
	SongStart;
	SongEnd;
	SongRetry;
	SongEvent;
	CountdownStart;
	CountdownStep;
	Pause;
	GameOver;

	// Freeplay
	FreeplayEnter;
	FreeplayExit;
	FreeplayIntro;
	FreeplayOutro;
	FreeplayIntroDone;
	FreeplayOutroDone;
	FreeplaySongSelected;
	FreeplaySongFavorited;
}
