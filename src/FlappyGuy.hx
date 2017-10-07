import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class FlappyGuy extends Scene {

  private var bird:Bird;
  private var time:Float = 0;

  public override function begin() {
    bird = new Bird(HXP.width / 3, HXP.height / 3);
    add(bird);

    add(new Pipe(HXP.width, -Std.random(300)));
    add(new Pipe(HXP.width + 300 * HXP.height / 540, HXP.height-Std.random(300) * HXP.height / 540));
    add(new Pipe(HXP.width + 600 * HXP.height / 540, -Std.random(300) * HXP.height / 540));

    super.begin();
  }

  public override function update() {
    time += HXP.elapsed;

    if(Input.check(Key.SPACE)) {
      HXP.scene = new FlappyGuy();
    }

    if(time > 4) {
      Globals.get_next_game(!bird.dead, function(data) {
        HXP.scene = new Score(data);
      });
    }
    super.update();
  }

}
