package base.utils.nodes
{
	public class Node
	{
		private var _obj:Object;
		private var _objects:Vector.<Object>;
		
		public function Node(object:Object = null, objects:Vector.<Object> = null)
		{
			_obj = object;
			_objects = objects;
		}
		
		public final function set object(object:Object):void {
			_obj = object;
		}
		
		public final function get object():Object {
			return _obj;
		}
		
		public final function get objects():Vector.<Object> {
			return _objects;
		}
		
		public final function addObject(object:Object):void {
			if (_objects == null) {
				_objects = new Vector.<Object>();
			}
			
			_objects.push(object);
		}
		
		public final function hasObject(object:Object):Boolean {
			if (_objects == null) {
				return false;
			}
			
			var index:Number = 0;
			var length:Number = _objects.length;
			if (object != null) {
				if (object is String) {
					while(index < length) {
						if (_objects[index].search(object) == 0) {
							return true;
						}
						index++;
					}
				} else {
					while(index < length) {
						if (_objects[index] == object) {
							return true;
						index++;
						}
					}
				}
			}
				
			return false;	
		}
		
		public final function objectEquals(object:Object):Boolean {
			if (_obj != null &&
				object != null &&
				(_obj == object || 
				(object is String && 
				_obj is String &&
				(_obj.search(object) == 0)))) {
					return true;
				}
			return false;
		}
	}
}