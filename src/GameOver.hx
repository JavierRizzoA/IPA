import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Backdrop;

class GameOver extends Scene
{
    
	
	public var Background:Entity;
	public var kwa:Image;
	public var won:Bool;
	public var kwas:Array<Entity>;

	public function new(win:Bool){
		kwas = new Array<Entity>();
		won = win;
		var img:Image;
		if(!win) {
			img = new Image("graphics/gameover.png");
			Background= new Entity(0,0, img);
		}
		else {
			img = new Image("graphics/winrar.png");
			img.scale = 0.5;
			img.centerOrigin();
			Background = new Entity(960 / 2, 540 / 2, img);
		}
		super();
	}

	override public function begin(){
		kwa = new Image("graphics/bottle.png");
		kwa.scale = 0.5;
		kwa.centerOrigin();

		var back:Backdrop = new Backdrop("graphics/sky.png", true, true);
		add(new Entity(0, 0, back));
		add(Background); 
		
	}

	override public function update() {
		if(won) {
			if(Std.random(100) < 10) {
				var e:Entity = new Entity(Std.random(960), 20, kwa);
				add(e);
				kwas.push(e);
			}
		}

		for(en in kwas) {
			en.y += 10;
		}

		kwa.angle += Std.random(12);
	
		super.update();
	}


}