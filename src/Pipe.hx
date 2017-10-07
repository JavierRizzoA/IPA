import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

class Pipe extends Entity {
  public function new(x:Float, y:Float) {
    super(x, y);
    var img = new Image("graphics/pipe.png");
    img.scale = HXP.height / 540;
    graphic = img;
    this.setHitbox(Std.int(100 * HXP.height / 540), Std.int(300 * HXP.height / 540));
    type = "pipe";
  }

  public override function update() {
    this.x = x - 10;
    super.update();
  }
}
