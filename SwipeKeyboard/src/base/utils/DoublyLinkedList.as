package base.utils
{
	import base.utils.nodes.ListNode;
	
	// Make sure to test this class before you use it! Has not been tested for correctness yet!
	
	public class DoublyLinkedList
	{
		private static const MIN_POSITION:Number = -1;
		private static const MAX_POSITION:Number = 10000;
		
		private var _headSentinel:ListNode;
		private var _tailSentinel:ListNode;
		
		private var _size:Number;
		
		
		public function DoublyLinkedList()
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
		
		public function add(object:Object):void {
			addToPos(object, 0);
		}
		
		public function addToPos(object:Object, position:Number):void {
			validatePosition(position);
			if (_size + 1 > MAX_POSITION) {
				throw new Error("The array has been filled.");
			}
			
			_size++;
			
			var curNode:ListNode = _headSentinel.nextNode;
			while(curNode.position < position) {
				curNode = curNode.nextNode;
			}
			
			if (curNode == _tailSentinel) {
				position = _size - 1;
			}
			var node:ListNode = new ListNode(object, position);

			node.nextNode = curNode;
			node.prevNode = curNode.prevNode;
			curNode.prevNode.nextNode = node;
			curNode.prevNode = node;
			
			while(curNode != _tailSentinel) {
				curNode.position++;
				curNode = curNode.nextNode;
			}
		}
		
		public function removeFromPos(position:Number):Object {
			validatePosition(position);
			
			var removeNode:ListNode = getNode(position);

			if (isEmpty() || removeNode == null) {
				return null;
			}
			
			var obj:Object = removeNode.object;
			
			var nextNode:ListNode = removeNode.nextNode;
			var prevNode:ListNode = removeNode.prevNode;
			
			nextNode.prevNode = prevNode;
			prevNode.nextNode = nextNode;
			
			removeNode.nextNode = null;
			removeNode.prevNode = null;
			removeNode.object = null;
			removeNode.position = -1;
			
			_size--;
			
			while(nextNode != _tailSentinel) {
				nextNode.position--;
				nextNode = nextNode.nextNode;
			}
			
			return obj;
			
		}

		public final function setObject(position:Number, object:Object):void {
			validatePosition(position);
			
			var node:ListNode = getNode(position);

			if (isEmpty() || node == null) {
				throw new Error("Element with position " + position + " could not be found.");	
			}
			
			node.object = object;
		}
		
		public final function getObject(position:Number):Object {
			validatePosition(position);
			
			var node:ListNode = getNode(position);
			
			if (isEmpty() || node == null) {
				throw new Error("Element with position " + position + " could not be found.");	
			}
			
			return node.object;
		}
		
		private final function getNode(position:Number):ListNode {
			validatePosition(position);
			
			var curNode:ListNode = _headSentinel.nextNode;
			
			while(curNode.position != position) {
				if (curNode == _tailSentinel) {
					return null;
				}
				
				curNode = curNode.nextNode;
			}
			
			return curNode;
		}
		
	}   
}