import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.Entity;
import com.haxepunk.screen.ScaleMode;

class Score extends Scene {
	public var time:Float = 0;
	public var state:Dynamic;

	public function new(n:String) {
		super();
		this.state = haxe.Json.parse(n);
	}

	override public function begin() {
		HXP.screen.scaleMode = new ScaleMode();
		HXP.screen.scaleMode.setBaseSize(960, 540);
		HXP.resize(HXP.windowWidth, HXP.windowHeight);
		add(new Entity(20, 20, new Text("Lives", 0, 0, 200, 200)));
		var array:Array<Text> = [new Text("" + state.lives[0], 100, 100, 200, 200),
		new Text("" + state.lives[1], 100, 100, 200, 200),
		new Text("" + state.lives[2], 100, 100, 200, 200),
		new Text("" + state.lives[3], 100, 100, 200, 200)];

		array[Globals.player_id].addStyle("red", {color: 0xFF0000});

		for(i in array) {
			i.size = 60;
		}
		add(new Entity(50, 50, array[0]));
		add(new Entity(300, 50, array[1]));
		add(new Entity(50, 300, array[2]));
		add(new Entity(300, 300, array[3]));
	}

	override public function update() {
		time += HXP.elapsed;

		if(time > 2.5) {
			HXP.scene = Globals.get_scene(state.game_id);
		}
	}
}