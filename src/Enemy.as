package  
{
	import flash.text.engine.BreakOpportunity;
	import org.flixel.*;

	public class Enemy extends FlxSprite
	{	
		[Embed(source = "data/enemy.png")] private var ImgEnemy:Class;
		private var colddown:Number;
		public var shootAngle:Number;
		public var rangeLength:Number;
		public var emitter:FlxEmitter;

		public function Enemy(X:Number = 0, Y:Number = 0, color:uint = FlxG.RED)
		{
			rangeLength = 150;
			shootAngle = 10;
			
			emitter = new FlxEmitter(0, 0, 3);
			var particle:FlxParticle;
			for(var i:uint = 0; i < 3; i++)
			{
				particle = new FlxParticle();
				particle.makeGraphic(3,3,color);
				particle.exists = false;
				emitter.add(particle);
			}

			colddown = 0;
			super(X, Y, ImgEnemy);
		}
		
		public function fire(player:Player):void
		{
			var distance:Number = FlxU.getDistance(getMidpoint(), player.getMidpoint());

			if (colddown == 0)
			{
				colddown = 50;
				player.hit(emitter);
			}
		}
		
		public function faceTo(player:Player):Number
		{
			var faceAngle:Number = FlxU.getAngle(getMidpoint(), player.getMidpoint()) - angle;

			if (faceAngle > 0)
			{
				angularVelocity = 50;
			}
			else
			{
				angularVelocity = -50;
			}
			
			return faceAngle;
		}

		override public function update():void
		{
			if (colddown > 0)
				colddown--;
			
			super.update();
		}
		
	}

}