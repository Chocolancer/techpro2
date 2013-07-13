package Objects 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Akari Nakashige
	 */
	public class Player extends IAG_Sprite
	{
		[Embed(source = "/../art/test_player.png")] public static var GFX_Player:Class;
		
		
		var isFacingForward:Boolean = false;
		
		public function Player() 
		{
			 this.loadGraphic(GFX_Player, true, true, 92, 92);
			 
			 this.addAnimation("idle", [0]);
			 this.addAnimation("running", [0,1,2,3,4,5,6],16);
			 this.play("idle");
		}
		
		
		override public function update():void 
		{
			super.update();
			acceleration.y = 600;
			
			if (FlxG.keys.A)
			{
				this.velocity.x = -70;
				isFacingForward = false;
				this.play("running");
			}
			else if (FlxG.keys.D)
			{
				this.velocity.x = 70;
				isFacingForward = true;
				this.play("running");
			}
			else if (FlxG.keys.W)
			{
				this.velocity.y = -70;
				this.play("running");
			}
			else if (FlxG.keys.S)
			{
				this.velocity.y = 70;
				this.play("running");
			}else
			{ 
				this.velocity.x = 0;
				this.play("idle");
			}
			
			if (isFacingForward)
			{
				this.facing = FlxObject.LEFT;
			}
			else
			{
				this.facing = FlxObject.RIGHT;
			}
			
			
		}
		
	}

}