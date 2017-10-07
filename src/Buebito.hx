import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;	
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Buebito extends Scene
{
    public var DelMonte:Entity;
	public var Sarten:Entity;
	public var Cocina:Entity;
    public var winer:Bool;
	public var Catsundrop:Catsun;
	public var Tryes:Int;
    public var velocity:Float;
	
	public function new(){
		super();
		Input.define("up", [Key.SPACE]);	
		Tryes=3;
		initial();
	
	}

	override public function begin(){
		
		HXP.screen.scaleX = HXP.width / 960;
		HXP.screen.scaleY = HXP.height / 540;
		add(Cocina); 
		add(DelMonte);
		add(Sarten);
	    add(Catsundrop);
		
	}

	override public function update() {
		  if (Input.check("up")||Input.mouseDown)
		        {
		       		Catsundrop.x=DelMonte.x;
		       		Catsundrop.y=DelMonte.y;
		        }/*
    		if(Sarten.collideWith(Catsundrop,480,0)!=null){
		       winer=true;
		  		Catsundrop.destroy();
		    }
		    else{
		     	if(Tryes>0){
		     		Tryes--;
		     	}
		       	else{
		       		winer=false;
		  		    Catsundrop.destroy();
		       	}
		    }*/
		updateSarten();
		//updateDelMonte();
		super.update();
	
}
	   public function initial(){

		Cocina= new Entity(0,0,new Image("graphics/cochina.png"));
		DelMonte= new Entity(20,20,new Image("graphics/catsun.png"));
		Sarten= new Entity(800,400,new Image("graphics/buebito.png"));
		Catsundrop= new Catsun(-200,-200);
		//Sarten.collide("SOLID",480,0);
		//DelMonte._graphic.angle=180;
	}
	public function updateSarten(){
		
		velocity =Std.random(100);
		if (Sarten.x>800){
			velocity= -velocity;
		}
        if (Math.abs(velocity) > 5)
        {
            velocity = 5 * HXP.sign(velocity);
        }
     

        Sarten.moveBy(velocity, 0);
	}

	public function updateDelMonte(){
		
	}
}