package base.utils
{
	import base.utils.nodes.ListNode;

	public class PriorityQueue
	{
		public static const MIN_POSITION:Number = -1;
		public static const MAX_POSITION:Number = 10000;
		
		private var _headSentinel:ListNode;
		private var _tailSentinel:ListNode;
		
		private var _size:Number;
		
		public final function PriorityQueue() 
		{
			_headSentinel = new ListNode(null, MIN_POSITION);
			_tailSentinel = new ListNode(null, MAX_POSITION); 
			
			_headSentinel.nextNode = _tailSentinel;
			_tailSentinel.prevNode = _headSentinel;
			
			_size = 0;
		}
		
		public final function isEmpty():Boolean {
			return _size == 0;
		}
		
		private function isValidPosition(position:Number):Boolean {
			return position < MAX_POSITION && position > MIN_POSITION ? true : false;
		}
		
		private final function validatePosition(position:Number):Error {
			if (!isValidPosition(position)) {
				throw new Error("Position must be between 0 and " + (MAX_POSITION - 1) + " inclusive.");
			} 
			
			return null;
		}
		
		public final function enqueue(object:Object, priority:Number):void {
			validatePosition(priority);
			if (_size + 1 > MAX_POSITION) {
				throw new Error("The array has been filled.");
			}
			
			var curNode:ListNode = _headSentinel.nextNode;
			while(curNode.position < priority) {
				curNode = curNode.nextNode;
			}
			
			var node:ListNode = new ListNode(object, priority);
			
			node.nextNode = curNode;
			node.prevNode = curNode.prevNode;
			curNode.prevNode.nextNode = node;
			curNode.prevNode = node;
			
			_size++;
		}
		
		public final function dequeue():Object {
			if (isEmpty()) {
				return null;
			}
			
			var node:ListNode = _headSentinel.nextNode;
			
			var obj:Object = node.object;
			
			var nextNode:ListNode = node.nextNode;
			
			nextNode.prevNode = _headSentinel;
			_headSentinel.nextNode = nextNode;
			
			node.nextNode = null;
			node.prevNode = null;
			node.object = null;
			node.position = -1;
			
			_size--;
			
			return obj;
		}
		
		public final function hasObject(object:Object):Boolean {
			var curNode:ListNode = _headSentinel;
			while(curNode != _tailSentinel) {
				if (curNode.objectEquals(object)) {
					return true;
				}
				curNode = curNode.nextNode;
			}
			
			return false;
		}
	}
}