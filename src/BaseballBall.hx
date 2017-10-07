import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.Sfx;

class BaseballBall extends Entity {
  public var hit:Bool;
  private var win:Sfx;
  private var fail:Sfx;
  private var pl:Bool;
  public function new(x:Float, y:Float) {
    super(x, y);
    var img = new Image("graphics/baseball.png");
    img.scale = HXP.height / 540;
    img.centerOrigin();
    graphic = img;
    setHitbox(Std.int(30*HXP.height/540), Std.int(30*HXP.height/540), Std.int(15*HXP.height/540), Std.int(15*HXP.height/540));
    hit = false;
    win = new Sfx("audio/BaseballSucc.ogg");
    fail = new Sfx("audio/BaseballFail.ogg");
    pl = false;
  }

  public override function update() {
    super.update();
    if(collide("bat", x, y) != null) {
      hit = true;
      win.play();
    }
    if(hit) {
      x-=25*HXP.height/540;
    } else {
      x+=20*HXP.height/540;
    }
    if(x > HXP.width && !pl) {
      fail.play();
      pl = true;
    }
  }
}
