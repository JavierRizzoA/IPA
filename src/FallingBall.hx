import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Graphiclist;
import haxe.Timer;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class FallingBall extends Scene
{
	var bottle:Entity;
	var bottle_image:Image;
	var bottle_speed:Float;
	var time:Float = 0;

	override public function begin()
	{
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
	}

	override public function update() {
		super.update();

		time += HXP.elapsed;

		if(time >= 10) {
			if(bottle.x > 380 && bottle.x < 580) {
				trace("you win");
			}
			else {
				trace("you lose");
			}
		}

		camera.y -= 100;
		bottle_image.angle += 10;

		var extra_chance:Float;
		if(bottle.x >= 480) {
			extra_chance = (960 - bottle.x) / 480;
		}
		else {
			extra_chance = (480 - bottle.x) / 480;
		}

		extra_chance *= 0.1;

		if(Math.random() < 0.01 + extra_chance) {
			bottle_speed = (Math.random() * 30) - 15;
		}

		if(bottle.x < 30) {
			bottle_speed = Math.abs(bottle_speed);
		}

		if(bottle.x > 930) {
			if(bottle_speed > 0) {
				bottle_speed *= -1;
			}
		}

		if(Input.check(Key.RIGHT)) {
			bottle.x += 20;
		}

		if(Input.check(Key.LEFT)) {
			bottle.x -= 20;
		}

		bottle.x += bottle_speed;
	}
}
