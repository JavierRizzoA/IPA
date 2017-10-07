import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;

class Bat extends Entity {
  public var image:Image;
  public function new(x:Float, y:Float) {
    super(x, y);
    image = new Image("graphics/bat.png");
    image.scale = HXP.height / 540;
    graphic = (image);
    setOrigin(10, 10);
    type="bat";
  }

  public override function update() {
    if(image.angle != 0) {
      image.angle += 15;
      image.angle %= 360;
    }
    if(Input.mousePressed) {
      image.angle += 15;
    }
    if(image.angle >= 90 && image.angle <= 270) {
      setHitbox(Std.int(20*HXP.height/540), Std.int(100*HXP.height/540), (image.angle < 180) ? Std.int(Math.sin((image.angle-90)*Math.PI/180)*25*HXP.height/540):Std.int(Math.sin((image.angle-90)*Math.PI/180)*25*HXP.height/540), Std.int(100*HXP.height/540));
    } else {
      setHitbox(0,0);
    }
    super.update();
  }
}
