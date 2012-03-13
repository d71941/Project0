package  
{
	import org.flixel.*;

	public class Player extends FlxSprite
	{
		[Embed(source = "data/player.png")] private var ImgPlayer:Class;

		public function Player(X:Number = 0, Y:Number = 0)
		{
			super(X, Y, ImgPlayer);
		}
		
		public function hit():void
		{
		}
	}

}