import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.Entity;
import haxe.Http;

class Loading extends Scene {
	override public function begin() {
		add(new Entity(0, 0, new Backdrop("graphics/sky.png", true, true)));

		var greet:Dynamic = Globals.greet();
		Globals.player_id = greet.player_id;
		HXP.scene = Globals.get_scene(greet.game_id);
	}

	override public function update() {
		super.update();
	}
}