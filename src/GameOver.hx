import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;


class GameOver extends Scene
{
    
	
	public var Background:Entity;

	public function new(){

		Background= new Entity(0,0,new Image("graphics/gameover.png"));
		super();
	}

	override public function begin(){
		add(Background); 
		
	}

	override public function update() {
		
	
		super.update();
	}


}