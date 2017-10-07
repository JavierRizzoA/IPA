import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

class Rogelia extends Entity {

  public function new(x:Float, y:Float) {
    super(x, y);
    var image:Image = new Image("graphics/rogelia.png");
    image.scale = HXP.height / 540;
    this.graphic = image;
  }

  public override function update() {
    this.x -= 10 * HXP.height / 540;
    super.update();
  }
}
