import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

class Catsun extends Entity
{

	public var velocity:Float;
    public var source:Image;
	public var acceleration:Float;
	
	public function new(X:Float, Y:Float){

 		super(X, Y);
  

		velocity =0;
        graphic = new Image("graphics/catsunfall.png");
        acceleration=4;

        setHitbox(32, 32);
        type = "bullet";
    }

	
     

    private function move()
    {
        velocity += acceleration;
        if (Math.abs(velocity) > 10)
        {
            velocity = 5 * HXP.sign(velocity);
        }
        moveBy( 0,velocity);
    }

    public override function update()
    {
        move();
        super.update();
    }
    public function destroy()
    {
        HXP.scene.remove(this);
    }

}
