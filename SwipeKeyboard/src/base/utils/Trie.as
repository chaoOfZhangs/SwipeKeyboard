package base.utils
{
	import base.utils.nodes.TrieNode;

	public class Trie
	{
		public static const IS_PREFIX:Number = -1;
		public static const IS_NOT_WORD:Number = -2;
		
		private var _root:TrieNode;
		private var _wordCount:Number;
		
		public function Trie()
		{
			_root = new TrieNode(null, IS_PREFIX);
			_wordCount = 0;
		}
		
		public function addWord(word:String, position:Number):Number {
			var curNode:TrieNode = _root;
			
			for (var x:Number = 0; x < word.length; x++) {
				var char:String = word.charAt(x).toLowerCase();
				var childNode:TrieNode = curNode.getChild(char);
				
				if (childNode == null) {
					childNode = new TrieNode(char, IS_PREFIX);
					curNode.addChild(childNode);
					childNode.parentNode = curNode;
				}
				
//				if (lastLetter.length != 0 && !childNode.hasObject(lastLetter)) {
//					childNode.addObject(lastLetter);
//				}
				
				curNode = childNode;
			}
			
			curNode.position = position;
			
			_wordCount++;
			
			return _wordCount;
		}
		
		public function findWord(word:String):Number {
			var position:Number = IS_NOT_WORD;
			var curNode:TrieNode = _root;
			
			while(word.length > 0) {
				var childNode:TrieNode = curNode.getChild(word.charAt(0));
				
//				|| (lastLetter.length != 0 && !childNode.hasObject(lastLetter)) 
				if (childNode == null ) {
					return IS_NOT_WORD;
				}
				
				curNode = childNode;
				
				word = word.substring(1, word.length);
			}
			position = curNode.position;

			return position;
		}
		
	}
}