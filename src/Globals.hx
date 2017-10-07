import haxe.Http;
import com.haxepunk.Scene;

class Globals {
	public static var player_id:Int;

	public static function greet():Dynamic {
		var message:Http = new Http("javierrizzo.com:8000");
		message.cnxTimeout = 180;
		message.request(false);
		return haxe.Json.parse(message.responseData);
	}

	public static function get_scene(game_id:Int):Scene {
		switch game_id {
			case 0: return new FallingBall();
			case 1: return new BarGame();
			case 2: return new Basket();
			case 3: return new Baseball();
			case 4: return new FlappyGuy();
			default: return null;
		}
	}

	public static function get_next_game(?win:Bool = false):Dynamic {
		var message:Http = new Http("javierrizzo.com:8000");
		var send:Dynamic = {
			player_id: Globals.player_id,
			player_won: win
		};
		message.setPostData(haxe.Json.stringify(send));
		message.cnxTimeout = 180;
		message.request(true);
		return haxe.Json.parse(message.responseData);
	}
}