import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;

class Basket extends Scene
{
  public var Good:Ball;
  public var Good1:Ball;
  public var Good2:Ball;
	public var Hole1:Entity;
	public var Background:Entity;
	public var total:Int;
	public var winer:Bool;
	private var time:Float = 0;
  private var sfx:Sfx;

	public function new(){
		super();
		this.initial();
		total=3;
    sfx = new Sfx("audio/BasketSfx.ogg");
	}

	override public function begin(){
		

		add(Background); 
		add(Hole1);
		add(Good);
		add(Good1);
		add(Good2);
    sfx.loop();
	}

	override public function update() {
		time += HXP.elapsed;
		if(time > 6) {
		    Globals.get_next_game(winer, function(data) {
		 		trace(data);
        		HXP.scene = new Score(data);
      		});
        sfx.stop();
		}

		Good.update();
		Good1.update();
		Good2.update();	
		
		
		if(Hole1.collideWith(Good1,416*HXP.height/540,32*HXP.height/540)!= null){
			Good1.destroy();
			total--;
		}

		if(Hole1.collideWith(Good,416*HXP.height/540,32*HXP.height/540)!= null){
			Good.destroy();
			total--;
		}

		if(Hole1.collideWith(Good2,416*HXP.height/540,32*HXP.height/540)!= null){
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
		Good= new Ball(Std.int(0*HXP.height/540),Std.int(476*HXP.height/540),HXP.random);
		Good1= new Ball(Std.int(416*HXP.height/540	),Std.int(476*HXP.height/540),HXP.random);
		Good2= new Ball(Std.int(896*HXP.height/540),Std.int(476*HXP.height/540),HXP.random);
		
		Hole1= new Entity(416*HXP.height/540,0*HXP.height/540,new Image("graphics/goal.png"));
		
		Background= new Entity(0*HXP.height/540,0*HXP.height/540,new Image("graphics/background1.png"));

		Hole1.collide("SOLID",Std.int(416*HXP.height/540),Std.int(0*HXP.height/540));

	}

}
