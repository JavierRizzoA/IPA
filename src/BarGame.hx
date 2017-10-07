import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;

class BarGame extends Scene {

  private var anims:Array<Image>;
  private var animsT:Array<Float>;
  private var frame:Int;
  private var e:Entity;
  private var cashada:Bool;
  private var cagua:Entity;
  private var time:Float = 0;
  private var wait_time:Float = 5;
  private var fail:Sfx;
  private var win:Sfx;
  private var slide:Sfx;

  override public function begin() {
    anims = [for(i in 0 ... 8) new Image("graphics/bar/sprite_" + i + ".png")];
    animsT = [0.5, 0.1, 0.1, (Std.random(1000) + 1) / 1000, 1000000, 0.1, 0.4, 1000000];

    win = new Sfx("audio/RogeliaSucc.ogg");
    fail = new Sfx("audio/RogeliaFail.ogg");
    slide = new Sfx("audio/RogeliaSlide.ogg");

    for(i in 0 ... 8) {
      anims[i].scale = HXP.height / 540;
    }

    frame = 0;
    e = addGraphic(anims[0]);
    cashada = false;
    super.begin();
  }

  override public function update() {
    time += HXP.elapsed;

    if(time >= wait_time) {
      if(!cashada) {
        slide.stop();
        fail.play();
      }
      Globals.get_next_game(cashada, function(data) {
        HXP.scene = new Score(data);
      });
    }

    animsT[frame] -= HXP.elapsed;
    if(animsT[frame] < 0) {
      frame++;

      if(frame == 7 && (cagua.x + 23) * HXP.height / 540 > 200 * HXP.height / 540 && (cagua.x + 23) * HXP.height / 540 < 310 * HXP.height / 540) {
        cashada = true;
      }

      if(frame == 4) {
        cagua = new Rogelia(HXP.width + 100, HXP.height / 2);
        slide.loop();
        add(cagua);
      }

      e.graphic = anims[frame];
    }

    if(frame == 4 && (Input.check(Key.SPACE) || Input.mouseDown)) {
      animsT[frame] -= 1000000;
    }

    if(cashada) {
      slide.stop();
      win.play();
      var im = new Image("graphics/bar/cashada.png");
      im.scale = HXP.height / 540;
      e.graphic = im;
      remove(cagua);
    }


    super.update();
  }
}
