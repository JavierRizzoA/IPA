package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__font_04b_03___ttf);
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:sizei21044y4:typey5:IMAGEy9:classNamey40:__ASSET__graphics_preloader_haxepunk_pngy2:idy35:graphics%2Fpreloader%2Fhaxepunk.pnggoR0i1216R1R2R3y42:__ASSET__graphics_debug_console_hidden_pngR5y37:graphics%2Fdebug%2Fconsole_hidden.pnggoR0i11620R1R2R3y40:__ASSET__graphics_debug_console_logo_pngR5y35:graphics%2Fdebug%2Fconsole_logo.pnggoR0i1275R1R2R3y43:__ASSET__graphics_debug_console_visible_pngR5y38:graphics%2Fdebug%2Fconsole_visible.pnggoR0i242R1R2R3y41:__ASSET__graphics_debug_console_debug_pngR5y36:graphics%2Fdebug%2Fconsole_debug.pnggoR0i242R1R2R3y40:__ASSET__graphics_debug_console_play_pngR5y35:graphics%2Fdebug%2Fconsole_play.pnggoR0i186R1R2R3y42:__ASSET__graphics_debug_console_output_pngR5y37:graphics%2Fdebug%2Fconsole_output.pnggoR0i251R1R2R3y40:__ASSET__graphics_debug_console_step_pngR5y35:graphics%2Fdebug%2Fconsole_step.pnggoR0i213R1R2R3y41:__ASSET__graphics_debug_console_pause_pngR5y36:graphics%2Fdebug%2Fconsole_pause.pnggoR0i17540R1y4:FONTR3y26:__ASSET__font_04b_03___ttfR5y19:font%2F04B_03__.ttfgoR0i1474R1R2R3y30:__ASSET__font_04b_03___ttf_pngR5y23:font%2F04B_03__.ttf.pnggh","version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__graphics_preloader_haxepunk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__graphics_debug_console_hidden_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__graphics_debug_console_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__graphics_debug_console_visible_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__graphics_debug_console_debug_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__graphics_debug_console_play_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__graphics_debug_console_output_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__graphics_debug_console_step_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__graphics_debug_console_pause_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__font_04b_03___ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__font_04b_03___ttf_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:image("/home/edgar/HaxePunk/2,6,1/assets/graphics/preloader/haxepunk.png") #if display private #end class __ASSET__graphics_preloader_haxepunk_png extends lime.graphics.Image {}
@:image("/home/edgar/HaxePunk/2,6,1/assets/graphics/debug/console_hidden.png") #if display private #end class __ASSET__graphics_debug_console_hidden_png extends lime.graphics.Image {}
@:image("/home/edgar/HaxePunk/2,6,1/assets/graphics/debug/console_logo.png") #if display private #end class __ASSET__graphics_debug_console_logo_png extends lime.graphics.Image {}
@:image("/home/edgar/HaxePunk/2,6,1/assets/graphics/debug/console_visible.png") #if display private #end class __ASSET__graphics_debug_console_visible_png extends lime.graphics.Image {}
@:image("/home/edgar/HaxePunk/2,6,1/assets/graphics/debug/console_debug.png") #if display private #end class __ASSET__graphics_debug_console_debug_png extends lime.graphics.Image {}
@:image("/home/edgar/HaxePunk/2,6,1/assets/graphics/debug/console_play.png") #if display private #end class __ASSET__graphics_debug_console_play_png extends lime.graphics.Image {}
@:image("/home/edgar/HaxePunk/2,6,1/assets/graphics/debug/console_output.png") #if display private #end class __ASSET__graphics_debug_console_output_png extends lime.graphics.Image {}
@:image("/home/edgar/HaxePunk/2,6,1/assets/graphics/debug/console_step.png") #if display private #end class __ASSET__graphics_debug_console_step_png extends lime.graphics.Image {}
@:image("/home/edgar/HaxePunk/2,6,1/assets/graphics/debug/console_pause.png") #if display private #end class __ASSET__graphics_debug_console_pause_png extends lime.graphics.Image {}
@:font("/home/edgar/HaxePunk/2,6,1/assets/font/04B_03__.ttf") #if display private #end class __ASSET__font_04b_03___ttf extends lime.text.Font {}
@:image("/home/edgar/HaxePunk/2,6,1/assets/font/04B_03__.ttf.png") #if display private #end class __ASSET__font_04b_03___ttf_png extends lime.graphics.Image {}
@:file("bin/neko/obj/tmp/manifest/default.json") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__font_04b_03___ttf') #if display private #end class __ASSET__font_04b_03___ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "font/04B_03__.ttf"; #end name = "04b03"; super (); }}


#end

#if (openfl && !flash)

@:keep @:expose('__ASSET__OPENFL__font_04b_03___ttf') #if display private #end class __ASSET__OPENFL__font_04b_03___ttf extends openfl.text.Font { public function new () { var font = new __ASSET__font_04b_03___ttf (); src = font.src; name = font.name; super (); }}


#end
#end