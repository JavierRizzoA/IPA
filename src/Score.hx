import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.Entity;

class Score extends Scene {
	public var time:Float = 0;
	public var state:Dynamic;

	public function new(n:Dynamic) {
		super();
		this.state = n;
	}

	override public function begin() {

		add(new Entity(20, 20, new Text("Lives", 0, 0, 200, 200)));
		add(new Entity(20, 20, new Text("" + state.lives[0], 100, 100, 200, 200)));
		add(new Entity(20, 20, new Text("" + state.lives[1], 100, 500, 200, 200)));
		add(new Entity(20, 20, new Text("" + state.lives[2], 500, 100, 200, 200)));
		add(new Entity(20, 20, new Text("" + state.lives[3], 500, 500, 200, 200	)));
	}

	override public function update() {
		time += HXP.elapsed;

		if(time > 2.5) {
			HXP.scene = Globals.get_scene(state.game_id);
		}
	}
}