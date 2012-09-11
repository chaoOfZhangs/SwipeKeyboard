package base.utils.nodes
{

	public class TrieNode extends Node
	{
		private var _parentNode:TrieNode;
		private var _childrenNodes:Vector.<TrieNode>;
		
		private var _position:Number;
		
		public function TrieNode(object:Object, index:Number)
		{
			super(object);
			_parentNode = null;
			_childrenNodes = new Vector.<TrieNode>();
			
			_position = index;
		}
		
		public function set parentNode(parentNode:TrieNode):void {
			_parentNode = parentNode;
		}
		
		public function get parentNode():TrieNode {
			return _parentNode;
		}
		
		public function set position(index:Number):void {
			_position = index;
		}
		
		public function get position():Number {
			return _position;
		}
		
		public function addChild(childNode:Node):void {
			_childrenNodes.push(childNode);			
		}
		
		public function getChild(object:Object):TrieNode {
			var length:Number = _childrenNodes.length;
			
			for (var x:Number = 0; x < length; x++) {
				if (_childrenNodes[x] != null && _childrenNodes[x].objectEquals(object))
				{
					return _childrenNodes[x];
				}
			}
			return null;
		}
		
		public function getChildren():Vector.<TrieNode> {
			return _childrenNodes;
		}
		
	}
}