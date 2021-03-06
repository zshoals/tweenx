import sample.Sprite;
import sample.Square;
import tweenxcore.color.HsvColor;
import tweenxcore.structure.FloatChange;
import tweenxcore.structure.FloatChangePart;
using tweenxcore.Tools;

class HsvSample extends Sprite { 
    public static var TOTAL_FRAME:Int = 40;
    private var frameCount:Int = 0;
    
    public function new() {
        super();
    }
    
    public function update():Void {
        var floatChange = new FloatChange(frameCount, frameCount += 1);
        floatChange.handlePart(0, 40, updatePart);
    }
    
    private function updatePart(part:FloatChangePart) {
        var prevX = part.previous.expoInOut().lerp(0, 480);
        var currentX = part.current.expoInOut().lerp(0, 480);

        var curve = part.current.expoInOut();
        var hue = curve.lerp(0.0, 1.0);
        var saturation = curve.lerp(0.0, 0.8);
        var value = 0.95;
        var color = new HsvColor(hue, saturation, value);

        var square = new Square();
        square.color = color;
        square.x = prevX;
        square.y = 60;
        square.width = currentX - prevX;
        addChild(square);
    }
}
