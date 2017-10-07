import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Basket extends Scene
{
    public var Good:Ball;
    public var Good1:Ball;
    public var Good2:Ball;
	public var Hole1:Entity;
	public var Background:Entity;
	public var total:Int;
	public var winer:Bool;

	public function new(){
		super();
		this.initial();
		total=3;
	}

	override public function begin(){
		add(Background); 
		add(Hole1);
		add(Good);
		add(Good1);
		add(Good2);
	}

	override public function update() {
		
		Good.update();
		Good1.update();
		Good2.update();	
		
		
		if(Hole1.collideWith(Good1,320,32)!= null){
			Good1.destroy();
			total--;
		}

		if(Hole1.collideWith(Good,320,32)!= null){
			Good.destroy();
			total--;
		}

		if(Hole1.collideWith(Good2,320,32)!= null){
			Good2.destroy();
			total--;
		}

		if (total<=1){
			winer=true;
			//this.end();
		}
		super.update();
	}

	public function initial(){
		Good= new Ball(0,416,HXP.random);
		Good1= new Ball(320,416,HXP.random);
		Good2= new Ball(576,416,HXP.random);
		
		Hole1= new Entity(320,0,new Image("graphics/goal.png"));
		
		Background= new Entity(0,0,new Image("graphics/background1.png"));

		Hole1.collide("SOLID",320,0);

	}

}