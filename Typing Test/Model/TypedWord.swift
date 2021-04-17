//
//  TypedWord.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 27/03/21.
//

import Foundation

struct TypedWord: Identifiable {
	let id = UUID()
	var word: String
	var isCorrect: Bool
}
