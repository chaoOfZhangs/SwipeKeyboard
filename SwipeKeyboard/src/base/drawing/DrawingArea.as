package base.drawing
{
	import mx.core.UIComponent;

	public class DrawingArea extends UIComponent
	{
		private var _prevX:Number = 0;
		private var _prevY:Number = 0;
		
		private var _component:UIComponent;
		
		private var _color:Number = 0;
		
		public function DrawingArea(component:UIComponent)
		{
			super();
			this._component = component;
		}
		
		public function start(x:Number, y:Number):void {
			_prevX = x;
			_prevY = y;
		}
		
		public function draw(toX:Number, toY:Number):void {
			_component.graphics.lineStyle(10, 0x00FF00, 1);
			_component.graphics.moveTo(_prevX, _prevY);
			_component.graphics.lineTo(toX, toY);
			
			_prevX = toX;
			_prevY = toY;
		}
		
		public function clear():void {
			_component.graphics.clear();
		}
		
	}
}