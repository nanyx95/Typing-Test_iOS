//
//  ContentView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 27/03/21.
//

import SwiftUI

struct ContentView: View {
	
	@State private var textFieldValue = ""
	
	var rightWords: [String] = ["test", "words", "from", "backend", "overflow", "pippo"]
	@State var leftWords: [String] = []
	
    var body: some View {
		HStack {
			Spacer().overlay(
				HStack {
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							ForEach(leftWords, id: \.self) { leftWord in
								Text(leftWord)
							}
							Text(textFieldValue)
								.foregroundColor(.green)
						}
						.rotationEffect(.degrees(180))
					}
					.disabled(true)
					.rotationEffect(.degrees(180))
				}
			)
			
			TextField(" ", text: $textFieldValue)
				.disableAutocorrection(true)
				.autocapitalization(.none)
//				.border(Color.black)
				.frame(width: 2, height: 0)
				.onChange(of: textFieldValue) {
					submitWord(word: $0)
				}
			
			Spacer().overlay(
				ScrollView(.horizontal, showsIndicators: false) {
					HStack {
						ForEach(rightWords, id: \.self) { rightWord in
							Text(rightWord)
//								.frame(width: .infinity, alignment: .leading)
						}
					}
				}
				.disabled(true)
			)
		}
	}
	
	func submitWord(word: String) {
		if word.suffix(1) == " " {
			leftWords.append(String(word.dropLast()))
			textFieldValue = ""
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
