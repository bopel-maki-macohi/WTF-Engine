package funkin.graphics.shader;

import flixel.system.FlxAssets.FlxShader;
import openfl.utils.Assets;

/**
 * A shader for swapping a texture with another texture.
 */
class TextureSwap extends FlxShader
{
	@:glFragmentSource('
        #pragma header

        uniform sampler2D texture;

        void main()
        {
            vec2 uv = openfl_TextureCoordv;
            vec4 color = texture2D(bitmap, uv);
            vec4 texColor = texture2D(texture, uv);

            if (color.a > 0.0)
            {
                color.rgb = texColor.rgb;
            }

            gl_FragColor = color;
        }
    ')
	public function new(id:String)
	{
		super();

		loadTexture(id);
	}

	public function loadTexture(id:String)
		texture.input = Assets.getBitmapData(Paths.image(id));
}
