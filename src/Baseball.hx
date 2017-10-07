import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;

class Baseball extends Scene {
  private var bat:Bat;
  private var pitcher:Entity;
  private var changed:Bool;
  private var time:Float;
  private var thrown:Bool;
  private var e:Float = 0;
  private var ball:BaseballBall;

  public override function begin() {
    super.begin();
    var im:Image = new Image("graphics/baseballpark.png");
    im.scale = HXP.height / 540;
    addGraphic(im);
    bat = new Bat(840 * HXP.height / 540, HXP.height / 2);
    add(bat);
    var pitchImg = new Image("graphics/pitcher1.png");
    pitchImg.scale = HXP.height / 540;
    pitchImg.centerOrigin();
    pitcher = addGraphic(pitchImg);
    pitcher.x = 300*HXP.height/540;
    pitcher.y = 255*HXP.height/540;
    changed = thrown = false;
  }

  public override function update() {
    super.update();

    e += HXP.elapsed;

    if(e > 4) {
      Globals.get_next_game(ball.hit, function(data) {
        HXP.scene = new Score(data);
      });
    }

    if(Std.random(90) == 0 && !changed) {
      var pitchImg = new Image("graphics/pitcher2.png");
      pitchImg.scale = HXP.height / 540;
      pitchImg.centerOrigin();
      pitcher.graphic = pitchImg;
      changed = true;
      time = Std.random(750) / 1000;
    }
    if(changed && !thrown) {
      time -= HXP.elapsed;
    }
    if(time < 0 && !thrown) {
      ball = new BaseballBall(300*HXP.height/540, 225*HXP.height/540);
      add(ball);
      thrown = true;
      var pitchImg = new Image("graphics/pitcher1.png");
      pitchImg.scale = HXP.height / 540;
      pitchImg.centerOrigin();
      pitcher.graphic = pitchImg;
    }
  }
}
