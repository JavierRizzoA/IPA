import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;

class Ball extends Entity
{

	public var velocity:Float;
	public var Good:Bool;
	public var sprite:Spritemap;
	public var acceleration:Float;
	public var I:Float;

	public function new(X:Int, Y:Int, i:Float){

 		super(X, Y);
        sprite = new Spritemap("graphics/sphere.png", 64, 64);
	    sprite.add("idle", [0]);
	    sprite.add("walk", [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],31);
	    sprite.play("idle");
		velocity =0;
		I=i;
        graphic = sprite;
        Input.define("up", [Key.SPACE]);
        setHitbox(32, 32);
        type = "bullet";
    }

    private function setAnimations()
    {
        if (velocity == 0)
        {
          
            sprite.play("idle");
        }
        else
        {
         
            sprite.play("walk");

           
            if (velocity < 0) // left
            {
                sprite.flipped = true;
            }
            else 
            {
                sprite.flipped = false;
            }
        }
    }
	
         private function handleInput()
    {
        acceleration = 0;


        if (Input.check("up"))
        {
            acceleration = 1.5;
        }
    }

    private function move()
    {
        velocity += acceleration;
        if (Math.abs(velocity) > 5)
        {
            velocity = 5 * HXP.sign(velocity);
        }
     

        moveBy(velocity, 0);
    }

    public override function update()
    {
        handleInput();

	    velocity-=0.2;

        move();
		
        setAnimations();
        y=y-(0.3+I);

        super.update();
    }
    public function destroy()
    {
        HXP.scene.remove(this);
    }

}
