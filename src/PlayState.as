package  
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private var player:Player;
		private var enemys:Array;
		
		
		override public function create():void
		{
			player = new Player();
			player.x = FlxG.width / 2 - player.width / 2;
			player.y = FlxG.height / 2 - player.height / 2;
			
			enemys = new Array(new Enemy(200, 50, 0xffff0000), new Enemy(400, 150, 0xffffff4d), new Enemy(200, 300, 0xff00ff00), new Enemy(400, 400, 0xffff5cff));

			var path:FlxPath = new FlxPath();
			path.add(FlxG.width / 2, FlxG.height);
			path.add(FlxG.width / 2, 0);
			
			player.followPath(path, 100, FlxObject.PATH_LOOP_FORWARD, true);
			
			add(player);
			
			for each(var enemy:Enemy in enemys)
			{
				add(enemy.emitter);
				add(enemy);
			}
		}

		override public function update():void
		{
			//trace(FlxU.getAngle(enemy.getMidpoint(),player.getMidpoint()));
			for each(var enemy:Enemy in enemys)
			{
				var distance:Number = FlxU.getDistance(enemy.getMidpoint(), player.getMidpoint());
				var faceAngle:Number = enemy.faceTo(player);
				
				if (FlxU.abs(faceAngle) < enemy.shootAngle && FlxU.abs(distance) < enemy.rangeLength)
				{
					enemy.fire(player);
				}
			}
			
			super.update();
		}

	}

}