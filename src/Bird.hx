import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.Sfx;

class Bird extends Entity {

  public var dead:Bool;
  private var m:Bool;
  private var vel:Float = 0;
  private var img:Image;
  private var sfx:Array<Sfx>;
  private var n:Int;

  public function new(x:Float, y:Float) {
    super(x, y);
    img = new Image("graphics/bird.png");
    img.scale = HXP.height / 540 / 2;
    img.centerOrigin();
    graphic = img;
    this.setHitbox(Std.int(100 * HXP.height / 540), Std.int(100 * HXP.height / 540));
    setHitbox(50,50);
    dead = false;
    m = true;
    sfx = [for(i in 1 ... 5) new Sfx("audio/FloppySfx" + i + ".ogg")];
    n = 0;
  }

  public override function update() {
    if(dead) {
      img.angle += 5;
      return;
    }
    if(Input.mouseDown && m && !dead) {
      vel = -10;
      m  = false;
      sfx[n].play();
      n++;
      n%=4;
      
    }
    if(!Input.mouseDown) {
      m = true;
    }

    if(this.collide("pipe", x, y) != null || y < 0 || y > HXP.height - 50 * HXP.height / 540) {
      dead = true;

    }

    vel += 0.5;
    this.y += vel;
    super.update();
  }
}
