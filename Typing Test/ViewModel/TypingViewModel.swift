//
//  TypingViewModel.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 10/04/21.
//

import Foundation
import SwiftUI

class TypingViewModel: ObservableObject {
	
	@Published var words: [Word]
	@Published var typedWords: [TypedWord]
	@Published var currentWord: String
	@Published var textFieldValue: String
	var flagWrongWord: Bool
	@Published var stats: Stats
	
	init() {
		self.words = [
			Word(word: "pippo"),
			Word(word: "pluto"),
			Word(word: "paperino"),
			Word(word: "paperina"),
			Word(word: "coniglio")
		]
		self.typedWords = []
		self.currentWord = ""
		self.textFieldValue = ""
		self.flagWrongWord = false
		self.stats = Stats()
	}
	
	func evaluateKeypress(word: String) {
		// set the new current word
		if currentWord.isEmpty {
			currentWord = words.first?.word ?? ""
		}
		print("currentword \(currentWord)")
		
		if word.suffix(1) == " " {
			print("spazio")
			onSpace(word: word)
//			getWord()
		} else if word == String(textFieldValue.dropLast()) {
			print("backspace")
			onBackspace(word: word)
		} else {
			print("lettera normale")
			onChar(word: word)
		}
	}
	
	private func onSpace(word: String) {
		if !word.trimmingCharacters(in: .whitespaces).isEmpty {
			// remove the space
			let wordWithoutSpace = String(word.dropLast())
			let isWordCorrect = wordWithoutSpace == currentWord ? true : false
			typedWords.append(TypedWord(word: wordWithoutSpace, isCorrect: isWordCorrect))
			// remove first item of the words array
			words.removeFirst()
			// update stats
			if isWordCorrect {
				stats.updateCorrectWord()
				stats.updateCorrectChars(charsToAdd: wordWithoutSpace.count)
			}
			stats.updateTotalWord()
			// set to null the current word
			currentWord = ""
			// clear input value
			textFieldValue = ""
			// set the incorrectness of the word to default
			flagWrongWord = false
		} else {
			textFieldValue = ""
		}
	}
	
	private func onBackspace(word: String) {
//		print("isback \(textFieldValue) == \(String(currentWord[..<textFieldValue.endIndex]))")
		if !currentWord.isEmpty && !textFieldValue.isEmpty && textFieldValue.count <= currentWord.count && textFieldValue == String(currentWord[..<textFieldValue.endIndex]) {
			words[0].word = String(textFieldValue.last!) + words[0].word
//			words[0].word = Stjring(word.last!) + words[0].word
//			flagWrongWord = false
		}
		if word.count <= currentWord.count && word == String(currentWord[..<word.endIndex]) {
			flagWrongWord = false
		} else {
			flagWrongWord = true
		}
		textFieldValue = word
	}
	
	private func onChar(word: String) {
		// check character
//		print("check char if: \(word) == \(String(currentWord[..<word.endIndex]))")
		if (word.count <= currentWord.count && word == String(currentWord[..<word.endIndex])) {
			print("modifico right word")
			words[0].word = String(words[0].word.dropFirst())
			flagWrongWord = false;
		} else {
			print("check char else")
			flagWrongWord = true;
		}
		textFieldValue = word
	}
	
	func onInput(word: String, isSpace: Bool = false, isBackspace: Bool = false) {
		// set the new current word
		if currentWord.isEmpty {
			currentWord = words.first?.word ?? ""
		}
		print("currentword \(currentWord)")
		
		if !isSpace {
		
		
		// check character
		print("check char if: \(word) == \(String(currentWord[..<word.endIndex])), back \(isBackspace)")
		if (word == String(currentWord[..<word.endIndex])) {
			if !isBackspace {
				print("modifico right word")
				words[0].word = String(words[0].word.dropFirst())
				flagWrongWord = false;
			} else if isBackspace {
				flagWrongWord = false
			}
		} else {
			print("check char else")
			flagWrongWord = true;
		}
		}
		
		
		/// todo - start the timer
		
		if isSpace && word.count != 1 {
			// remove the space
			let wordWithoutSpace = String(word.dropLast())
			typedWords.append(TypedWord(word: wordWithoutSpace, isCorrect: wordWithoutSpace == currentWord ? true : false))
			// remove first item of the words array
			words.removeFirst()
			// set to null the current word
			currentWord = ""
			// clear input value
			textFieldValue = ""
			// set the incorrectness of the word to default
			flagWrongWord = false
		} else if isBackspace {
			print("isback \(textFieldValue) == \(String(currentWord[..<textFieldValue.endIndex]))")
			if currentWord != "" && textFieldValue == String(currentWord[..<textFieldValue.endIndex]) {
				if !textFieldValue.isEmpty {
					words[0].word = String(textFieldValue.last!) + words[0].word
				}
//				words[0].word = Stjring(word.last!) + words[0].word
			}
		}
		if !isSpace {
			textFieldValue = word
		}
		
		print()
	}
	
	func getWords(number: Int) {
		let path = "words/\(number)"
		
		NetworkManager.shared.fetch(with: path, generalType: [Word].self) { result in
			switch result {
			case .success(let words):
				self.words = words
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func getWord() {
		let path = "word"
		
		NetworkManager.shared.fetch(with: path, generalType: Word.self) { result in
			switch result {
			case .success(let word):
				self.words.append(word)
			case .failure(let error):
				print(error)
			}
		}
	}
	
}
