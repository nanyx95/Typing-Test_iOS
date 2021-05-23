//
//  Stats.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 23/05/21.
//

import Foundation

struct Stats {
	private(set) var totalWords: Int = 0
	private(set) var correctWords: Int = 0
	private(set) var correctChars: Int = 0
	var accuracy: Int {
		if totalWords == 0 {
			return 0
		} else {
			return Int(Double((Double(correctWords) / Double(totalWords)) * 100).rounded())
		}
	}
	var topWPM: Int = 0
	
	mutating func updateTotalWord() {
		totalWords += 1
	}
	
	mutating func updateCorrectWord() {
		correctWords += 1
	}
	
	mutating func updateCorrectChars(charsToAdd chars: Int) {
		correctChars += chars
	}
	
	mutating func resetStats() {
		totalWords = 0
		correctWords = 0
		correctChars = 0
	}
}
