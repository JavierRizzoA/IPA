import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;

class Bird extends Entity {

  public var dead:Bool;
  private var m:Bool;

  public function new(x:Float, y:Float) {
    super(x, y);
    var img = new Image("graphics/bird.png");
    img.scale = HXP.height / 540;
    graphic = img;
    this.setHitbox(Std.int(100 * HXP.height / 540), Std.int(100 * HXP.height / 540));
    setHitbox(100,100);
    dead = false;
    m = true;
  }

  public override function update() {
    this.y += 5 * (HXP.height / 540);
    if(dead) this.y += 5 * (HXP.height / 540);
    if(Input.mouseDown && m && !dead) {
      m  = false;
      this.y -= 20 * 5 * (HXP.height / 540);
    }
    if(!Input.mouseDown) {
      m = true;
    }

    if(this.collide("pipe", x, y) != null || y < 0 || y > HXP.height - 100 * HXP.height / 540) {
      dead = true;
    }
    super.update();
  }
}
