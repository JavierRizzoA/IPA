import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import haxepunk.screen.ScaleMode;
import haxe.Http;

class FallingBall extends Scene
{
	var bottle:Entity;
	var bottle_image:Image;
	var bottle_speed:Float;
	var time:Float = 0;
	var win:Bool;
	var finished:Bool = false;
	var resized:Bool = false;

	override public function begin()
	{

		HXP.screen.scaleMode = new ScaleMode();
		HXP.screen.scaleMode.setBaseSize(960, 540);
		HXP.resize(HXP.windowWidth, HXP.windowHeight);
		var b1:Backdrop;
		b1 = new Backdrop("graphics/sky.png", true, true);
		b1.scrollY = 0.4;
		b1.scale = 1.2;

		var b2:Backdrop;
		b2 = new Backdrop("graphics/sky2.png", true, true);
		b2.scrollY = 0.8;
		b2.scale = 1.2;

		var background:Entity;
		background = new Entity(0, 0, new Graphiclist([b1, b2]));
		background.followCamera = true;
		add(background);

		bottle_image = new Image("graphics/bottle.png");
		bottle_image.centerOrigin();
		bottle_image.scale = 0.5;

		bottle = new Entity(480, 40, bottle_image);
		bottle.followCamera = true;
		add(bottle);
		bottle_speed = 0;

		var catcher:Entity = new Entity(230, 350, new Image("graphics/catch.png"));
		catcher.followCamera = true;
		add(catcher);

	}

	function should_move():Bool {
		var extra_chance:Float;
		if(bottle.x >= 480) {
			extra_chance = (960 - bottle.x) / 480;
		}
		else {
			extra_chance = (480 - bottle.x) / 480;
		}

		extra_chance *= 0.1;

		if(Math.random() < 0.01 + extra_chance) {
			return true;
		}

		return false;
	}

	override public function update() {
		super.update();

		if(!resized) {
			HXP.resize(HXP.windowWidth, HXP.windowHeight);
			resized = true;
		}

		time += HXP.elapsed;

		if(time >= 5 && !finished) {
			camera.y = 0;
			win = bottle.x > 380 && bottle.x < 580;
			finished = true;
		}

		if(!finished) {
			camera.y -= 100;
			bottle_image.angle += 10;

			if(should_move()) {
				bottle_speed = (Math.random() * 30) - 15;
			}

			if(bottle.x < 30) {
				bottle.x = 30;
			}

			if(bottle.x > 930) {
				bottle.x = 930;
			}

			if(Input.mouseDown) {
				if(Input.mouseX <= 480) {
					bottle.x -= 20;
				}
				else {
					bottle.x += 20;
				}
			}

			bottle.x += bottle_speed;
		}
		else {
			bottle.y += 20;

			if(win && bottle.y >= 300) {
				bottle.y = 360;
				bottle.x = 420;
			}

			if(time > 7) {
				Globals.get_next_game(win, function(data) {
					HXP.scene = new Score(data);
      			});
			}
		}
	}
}	
