//
//  Word.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 10/04/21.
//

import Foundation

struct Word: Identifiable {
	let id = UUID()
	var word: String
}

extension Word: Decodable {
	private enum CodingKeys: String, CodingKey {
		case word
	}
}
