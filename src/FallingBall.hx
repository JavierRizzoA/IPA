import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;

class FallingBall extends Scene
{

	override public function begin()
	{
		var b1:Backdrop;
		var b2:Backdrop;
		var background:Entity;

		HXP.stage.color = 0x0000000;

		b1 = new Backdrop("graphics/sky.png", true);
		b1.scrollX = 0.4;
		b1.scale = 1.2;

		b2 = new Backdrop("graphics/sky.png", true);
		b2.scrollX = 0.6;
		b2.scale = 1.2;

		background = new Entity(0, 0, new Graphiclist([b1, b2]));
		background.followCamera = true;
		add(background);
	}

	override public function update() {
		//sky.y += 10;
	}
}
