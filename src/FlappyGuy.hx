import com.haxepunk.HXP;
import com.haxepunk.Scene;

class FlappyGuy extends Scene {

  private var bird:Bird;

  public override function begin() {
    bird = new Bird(HXP.width / 3, HXP.height / 3);
    add(bird);

    add(new Pipe(HXP.width, -Std.random(300)));
    add(new Pipe(HXP.width + 300 * HXP.height / 540, HXP.height-Std.random(300) * HXP.height / 540));
    add(new Pipe(HXP.width + 600 * HXP.height / 540, -Std.random(300) * HXP.height / 540));

    super.begin();
  }

  public override function update() {

    super.update();
  }

}