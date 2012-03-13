package  
{
	import flash.text.engine.BreakOpportunity;
	import org.flixel.*;

	public class Enemy extends FlxSprite
	{	
		[Embed(source = "data/enemy.png")] private var ImgEnemy:Class;
		private var colddown:Number;
		public var aimAngle:Number;
		public var shootAngle:Number;
		public var aimRange:Number;
		public var shootRange:Number;
		public var emitter:FlxEmitter;
		public var spark:FlxEmitter;
		public var faceDirection:Number;

		public function Enemy(X:Number = 0, Y:Number = 0,direction:Number = 0, color:uint = FlxG.RED)
		{
			shootRange = 150;
			shootAngle = 10;
			aimRange = 300;
			aimAngle = 60;
			
			
			emitter = new FlxEmitter(0, 0, 5);
			var particle:FlxParticle;
			var i:uint
			for(i = 0; i < 5; i++)
			{
				particle = new FlxParticle();
				particle.makeGraphic(3,3,color);
				particle.exists = false;
				emitter.add(particle);
			}
			
			spark = new FlxEmitter(0, 0, 20);
			for(i = 0; i < 20; i++)
			{
				particle = new FlxParticle();
				particle.makeGraphic(1, 1, color);
				particle.exists = false;
				spark.add(particle);
			}

			colddown = 0;
			super(X, Y, ImgEnemy);
			faceDirection = direction;
			angle = faceDirection;
		}
		
		public function fire(player:Player):void
		{
			var midX:Number = getMidpoint().x;
			var midY:Number = getMidpoint().y;

			if (colddown == 0)
			{
				colddown = 50;
				emitter.at(player);
				emitter.start(true, 0.5, 0, 0);
				
				//put the sprak ib front the muzzle
				var muzzle:FlxPoint = FlxU.rotatePoint(midX, midY - height / 2, midX, midY, angle);
				spark.x = muzzle.x;
				spark.y = muzzle.y;
				spark.start(true, 0.1, 0, 0);
				player.hit();
			}
		}
		
		public function faceTo(faceAngle:Number):void
		{
			if (FlxU.abs(faceAngle-faceDirection) > aimAngle)
			{
				faceAngle = faceDirection;
			}

			if (faceAngle == angle)
			{
				angularVelocity = 0;
			}
			else if (faceAngle - angle > 0)
			{
				angularVelocity = 50;
			}
			else
			{
				angularVelocity = -50;
			}
		}

		override public function update():void
		{
			if (colddown > 0)
				colddown--;
			
			super.update();
		}
		
	}

}