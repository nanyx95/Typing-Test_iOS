//
//  TypingViewModel.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 10/04/21.
//

import Foundation
import SwiftUI

class TypingViewModel: ObservableObject {
	
	@Published var words: [Word] = [Word(word: "Random"), Word(word: "Word"), Word(word: "Placeholder")]
	@Published var typedWords: [TypedWord] = []
	@Published var currentWord: String = ""
	@Published var textFieldValue: String = ""
	@Published var stats: Stats = Stats()
	@Published var isLoading: Bool = true
	var flagWrongWord: Bool = false
	let userId: String
	var topWPM: Int
	
	init() {
		// get/generate user id
		if let userId = UserDefaults.standard.string(forKey: "user-uuid") {
			self.userId = userId
		} else {
			self.userId = UUID().uuidString
			UserDefaults.standard.set(self.userId, forKey: "user-uuid")
		}
		print("user-uuid: \(userId)")
		
		// get topWPM
		self.topWPM = UserDefaults.standard.integer(forKey: "top-wpm")
		
		NetworkAPI.shared.getWords(number: 5) { words in
			DispatchQueue.main.async {
				self.isLoading = false
			}
			self.words = words
		}
	}
	
	func resetTypingTest() {
		NetworkAPI.shared.getWords(number: 5) { words in
			self.words = words
		}
		typedWords = []
		currentWord = ""
		textFieldValue = ""
		flagWrongWord = false
		stats.resetStats()
	}
	
	func saveTopWPMInUserDefaults() {
		if stats.correctWords > topWPM {
			topWPM = stats.correctWords
			UserDefaults.standard.set(topWPM, forKey: "top-wpm")
		}
	}
	
	func evaluateKeypress(word: String) {
		// set the new current word
		if currentWord.isEmpty {
			currentWord = words.first?.word ?? ""
		}
		
		if word.suffix(1) == " " {
			onSpace(word: word)
			NetworkAPI.shared.getWord() { word in
				guard let word = word else { return }
				self.words.append(word)
			}
		} else if word == String(textFieldValue.dropLast()) {
			onBackspace(word: word)
		} else {
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
		if !currentWord.isEmpty && !textFieldValue.isEmpty && textFieldValue.count <= currentWord.count && textFieldValue == String(currentWord[..<textFieldValue.endIndex]) {
			words[0].word = String(textFieldValue.last!) + words[0].word
		}
		if word.count <= currentWord.count && word == String(currentWord[..<word.endIndex]) {
			flagWrongWord = false
		} else {
			flagWrongWord = true
		}
		textFieldValue = word
	}
	
	private func onChar(word: String) {
		if (word.count <= currentWord.count && word == String(currentWord[..<word.endIndex])) {
			words[0].word = String(words[0].word.dropFirst())
			flagWrongWord = false;
		} else {
			flagWrongWord = true;
		}
		textFieldValue = word
	}
	
}
