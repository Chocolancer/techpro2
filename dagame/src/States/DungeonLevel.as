package States
{
	import Objects.*;
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	import Objects.WhiteKnight;
	import States.*;
	/**
	 * ...
	 * @author Akari Nakashige
	 */
	public class DungeonLevel extends IAG_GameLevelState 
	{		
		private var checkpoint1:FlxSprite;
		private var checkpoint2:FlxSprite;
		private var checkpoint3:FlxSprite;
		private var checkpoint4:FlxSprite;
		private var checkpoint5:FlxSprite;
		private var cps:FlxGroup = new FlxGroup();
		private var boss:WhiteKnight;
		
		public function DungeonLevel() 
		{ 
			super();
			tmap = new FlxTilemap();
			tmap.loadMap(new Resources.TMAP_Dungeon, Resources.GFX_TestTileSet, 32, 32);
			tmap.setTileProperties(3, 0x1111, FloorSpikeCollisionCallback);
			tmap.setTileProperties(4, 0x1111, CeilingSpikeCollisionCallback);
			tmap.setTileProperties(5, 0x1111, PopBoxCollisionCallback);
			this.checkPoints[0] = [ 312, 80];
			this.checkPoints[1] = [ 1950, 1310];
			this.checkPoints[2] = [ 936, 336];
			this.checkPoints[3] = [ 2650, 1328];
			this.checkPoints[4] = [ 4960, 336];
			this.checkPoints[5] = [ 7105, 1230];
			checkpoint1 = new FlxSprite(1950, 1344);
			checkpoint2 = new FlxSprite(936, 352);
			checkpoint3 = new FlxSprite(2650, 1344);
			checkpoint4 = new FlxSprite(4960, 352);
			checkpoint5 = new FlxSprite(7105, 1248);
			checkpoint1.loadGraphic(Resources.GFX_Checkpoint, false, false, 32, 64);
			checkpoint1.addAnimation("alive", [0],0);
			checkpoint1.play("alive");
			checkpoint1.addAnimation("dead", [1],0);
			checkpoint2.loadGraphic(Resources.GFX_Checkpoint, false, false, 32, 64);
			checkpoint2.addAnimation("alive", [0],0);
			checkpoint2.play("alive");
			checkpoint2.addAnimation("dead", [1],0);
			checkpoint3.loadGraphic(Resources.GFX_Checkpoint, false, false, 32, 64);
			checkpoint3.addAnimation("alive", [0],0);
			checkpoint3.play("alive");
			checkpoint3.addAnimation("dead", [1],0);
			checkpoint4.loadGraphic(Resources.GFX_Checkpoint, false, false, 32, 64);
			checkpoint4.addAnimation("alive", [0],0);
			checkpoint4.play("alive");
			checkpoint4.addAnimation("dead", [1],0);
			checkpoint5.loadGraphic(Resources.GFX_Checkpoint, false, false, 32, 64);
			checkpoint5.addAnimation("alive", [0],0);
			checkpoint5.play("alive");
			checkpoint5.addAnimation("dead", [1],0);
			cps.add(checkpoint1);
			cps.add(checkpoint2);
			cps.add(checkpoint3);
			cps.add(checkpoint4);
			cps.add(checkpoint5);
			add(cps);
			
			boss = new WhiteKnight(this);
			add(boss);
		}
		
		override public function create():void 
		{
			super.create();	
			player.x = checkPoints[currentCheckPoint][0];
			player.y = checkPoints[currentCheckPoint][1];
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.overlap(this.player, this.cps, checkPointCallback);
			FlxG.overlap(this.player, this.boss, endgameCallback);
		}
		
		private function endgameCallback(nothing:FlxObject, nothing2:FlxObject):void
		{
			sound.loadEmbedded(Resources.SND_Nextlevel);
			sound.play(true);
			FlxG.switchState(new DiscoLevel());
		}
		
		private function checkPointCallback(nothing:FlxObject, nothing2:FlxObject):void
		{
			if (nothing2.alive)
			{
				nothing2.alive = false;
				var temp:FlxSprite = nothing2 as FlxSprite;
				temp.play("dead");
				currentCheckPoint++;
			}
		}
		
		private function PopBoxCollisionCallback(Tile:FlxTile, Object:FlxObject):void {
			
			if (player.isTouching(0x1000))
			{
				var box:PopUpBox = new PopUpBox(this, Tile.x, Tile.y);
				this.add(box.spikes);
				box.Activate();
			}
		}
		
		private function FloorSpikeCollisionCallback(Tile:FlxTile, target:FlxObject):void 
		{
			if (player.justTouched(0x1000))
			{
				if (target is Player)
				{
					onDeath();
				}
			}
		}
		private function CeilingSpikeCollisionCallback(Tile:FlxTile, target:FlxObject):void 
		{
			if (player.justTouched(0x0100))
			{
				if (target is Player)
				{
					onDeath();
				}
			}
		}
		
		private function afterDeathShake():void
		{
			camera.flash();
			bringToLife();
		}
	}
}
