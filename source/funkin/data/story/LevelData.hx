package funkin.data.story;

/**
 * A structure object used for level data.
 */
typedef LevelData = {
    var name:String;
    @:optional
    var title:String;
    @:default([])
    var songs:Array<String>;
    var opponent:String;
    var player:String;
    var gf:String;
    @:default('#FFCB2F')
    var color:String;
}