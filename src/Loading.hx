import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.Entity;
import haxe.Http;

class Loading extends Scene {
	override public function begin() {
		add(new Entity(0, 0, new Backdrop("graphics/sky.png", true, true)));

		Globals.greet(function(data:String) {
			var d:Dynamic = haxe.Json.parse(data);
			Globals.player_id = d.player_id;
			//trace(Globals.player_id);
			HXP.scene = Globals.get_scene(d.game_id);
		});
	}

	override public function update() {
		super.update();
	}
}