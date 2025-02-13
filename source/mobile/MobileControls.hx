package mobile;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxDestroyUtil;
import mobile.FlxHitbox;
import mobile.FlxHitbox.Modes;
/**
 * @author Mihai Alexandru (M.A. Jigsaw)
 */
class MobileControls extends FlxSpriteGroup
{

	public var hitbox:FlxHitbox;

	public function new(hType:Modes = DEFAULT)
	{
		super();

	        hitbox = new FlxHitbox(hType);
		add(hitbox);
	}

	override public function destroy():Void
	{
		super.destroy();

		if (hitbox != null)
			hitbox = FlxDestroyUtil.destroy(hitbox);
	}
}
