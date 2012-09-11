package base.utils.nodes
{
	public class ListNode extends Node
	{	
		private var _position:Number;
		
		private var _prevNode:ListNode;
		private var _nextNode:ListNode;
		
		public function ListNode(object:Object, priority:Number) {
			super(object);
			_position = priority;
			
			_prevNode = null;
			_nextNode = null;
		}
		
		public final function set position(position:Number):void {
			_position = position;
		}
		
		public final function get position():Number {
			return _position;
		}
		
		public final function get prevNode():ListNode {
			return _prevNode;
		}
		
		public final function set prevNode(prevNode:ListNode):void {
			_prevNode = prevNode;
		}
		
		public final function get nextNode():ListNode {
			return _nextNode;
		}
		
		public final function set nextNode(nextNode:ListNode):void {
			_nextNode = nextNode;
		}
	}
}