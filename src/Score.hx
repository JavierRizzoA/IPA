import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.Entity;
import com.haxepunk.screen.ScaleMode;

class Score extends Scene {
	public var time:Float = 0;
	public var state:Dynamic;

	public function new(n:Dynamic) {
		super();
		this.state = n;
	}

	override public function begin() {
		HXP.screen.scaleMode = new ScaleMode();
		HXP.screen.scaleMode.setBaseSize(960, 540);
		HXP.resize(HXP.windowWidth, HXP.windowHeight);
		add(new Entity(20, 20, new Text("Lives", 0, 0, 200, 200)));

		var text1:Text = new Text("" + state.lives[0], 100, 100, 200, 200);
		text1.size = 60;
		var text2:Text = new Text("" + state.lives[1], 100, 100, 200, 200);
		text2.size = 60;
		var text3:Text = new Text("" + state.lives[2], 100, 100, 200, 200);
		text3.size = 60;
		var text4:Text = new Text("" + state.lives[3], 100, 100, 200, 200);
		text4.size = 60;
		add(new Entity(50, 50, text1));
		add(new Entity(300, 50, text2));
		add(new Entity(50, 300, text3));
		add(new Entity(300, 300, text4));
	}

	override public function update() {
		time += HXP.elapsed;

		if(time > 2.5) {
			HXP.scene = Globals.get_scene(state.game_id);
		}
	}
}