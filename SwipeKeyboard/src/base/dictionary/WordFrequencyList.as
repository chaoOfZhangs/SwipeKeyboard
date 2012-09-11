package base.dictionary
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	
	import base.utils.PriorityQueue;
	import base.utils.Trie;

	public class WordFrequencyList
	{
		public static const EMPTY_STRING:String = "";
		
		private var _trie:Trie;
		private var _priorityQ:PriorityQueue;
		
		public function WordFrequencyList()
		{
			_trie = new Trie();
			_priorityQ = new PriorityQueue();
		}
		
		public function uploadWordList(path:String):Array {
			var file:File = File.applicationDirectory;
			file = file.resolvePath(path);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			
			var wordListString:String = fileStream.readUTFBytes(fileStream.bytesAvailable);

			var wordList:Array = wordListString.split("\n");
			fileStream.close();
			
			var length:Number = wordList.length;
			
			for (var x:Number = 0; x < length; x++) {
				var word:String = StringUtil.trim(wordList[x]);
				word = word.toLowerCase();
				_trie.addWord(word, x);
			}
			
			return wordList;
		}
		
		public function findXBestWords(letters:String, xBest:Number):Array {
			var xBestWords:Array = new Array(xBest);
			letters = letters.toLowerCase();
			makeWords(letters.substring(1), "", letters.charAt(0));
			
			var index:Number = 0;
			while (index < xBest) {
				if (!_priorityQ.isEmpty()) {
					var word:Object = _priorityQ.dequeue();
					if (word is String && (word.charAt(0) == letters.charAt(0)) && (word.charAt(word.length - 1) == letters.charAt(letters.length - 1))) {
						xBestWords[index] = word;
						index++;
					}
				} else {
					xBestWords[index] = EMPTY_STRING;
					index++;
				}
			}
			
			return xBestWords;
		}
		
		private function makeWords(unprocessed:String, processed:String, firstLetter:String=""):void {
			var pos:Number = _trie.findWord(firstLetter + processed);
			if (pos == Trie.IS_NOT_WORD) {
				return;
			} else if (pos > Trie.IS_PREFIX) {
				if (!_priorityQ.hasObject(firstLetter + processed)) {
					_priorityQ.enqueue(firstLetter + processed, pos);
				}
			}
			
			if (unprocessed.length == 1) {
				pos = _trie.findWord(firstLetter + processed + unprocessed);
				if (pos > Trie.IS_PREFIX) {
					if (!_priorityQ.hasObject(firstLetter + processed + unprocessed)) {
						_priorityQ.enqueue(firstLetter + processed + unprocessed, pos);
					}
				}
				return;
			} 
			
			for (var x:Number = 0; x < unprocessed.length; x++) {
				var temp:String = unprocessed;
				
				var firstChar:String = temp.substring(x, x+1);
//				var preFirst:String = temp.substring(0, x); // Concat this to the beginning of afterFirst in the recurse call to search anagram spaces as well
				var afterFirst:String = temp.substring(x+1, unprocessed.length);
				
				makeWords(afterFirst, processed + firstChar, firstLetter);
			}
		}
	}
}