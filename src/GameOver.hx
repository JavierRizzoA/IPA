import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;


class GameOver extends Scene
{
    
	
	public var Background:Entity;

	public function new(win:Bool){
		if(win) {
			Background= new Entity(0,0,new Image("graphics/gameover.png"));
		}
		else {
			Background = new Entity(0, 0, new Image("graphics/youwin.jpg"));
		}
		super();
	}

	override public function begin(){
		add(Background); 
		
	}

	override public function update() {
		
	
		super.update();
	}


}