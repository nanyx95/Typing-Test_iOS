//
//  ContentView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 27/03/21.
//

import SwiftUI
import MbSwiftUIFirstResponder

struct ContentView: View {
	
	@State private var textFieldValue = ""
	
	var rightWords: [String] = ["test", "words", "from", "backend", "overflow", "pippo"]
	@State var leftWords: [String] = []
	
	enum FirstResponders: Int {
		case inputWord
	}
	@State var firstResponder: FirstResponders? = nil
	
    var body: some View {
		VStack {
			Spacer()
			
			Text("Typing Test")
				.fontWeight(.light)
				.foregroundColor(Color("title"))
				.tracking(3)
				.padding(.all)
				.textCase(.uppercase)
			Text("Test your typing skills")
				.font(.system(size: 30))
				.fontWeight(.bold)
				.foregroundColor(Color("subtitle"))
				
			Spacer()
			
			Text("Timer placeholder")
			
			Spacer()
			
			HStack {
				Spacer().overlay(
					HStack {
						ScrollView(.horizontal, showsIndicators: false) {
							HStack {
								ForEach(leftWords, id: \.self) { leftWord in
									Text(leftWord)
										.foregroundColor(Color("typed-words"))
										.padding(-1.0)
								}
								Text(textFieldValue)
									.foregroundColor(Color("current-word"))
									.padding(-1.0)
							}
							.rotationEffect(.degrees(180))
						}
						.disabled(true)
						.rotationEffect(.degrees(180))
					}
				)
				
				TextField(" ", text: $textFieldValue, onCommit: { firstResponder = nil })
					.firstResponder(id: FirstResponders.inputWord, firstResponder: $firstResponder, resignableUserOperations: .all)
					.disableAutocorrection(true)
					.autocapitalization(.none)
					.foregroundColor(.white)
					.accentColor(.black)
					.lineLimit(1)
	//				.border(Color.black)
					.frame(width: 1, height: 0)
					.onChange(of: textFieldValue) {
						submitWord(word: $0)
					}
				
				Spacer().overlay(
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							ForEach(rightWords, id: \.self) { rightWord in
								Text(rightWord)
									.padding(-1.0)
	//								.frame(width: .infinity, alignment: .leading)
							}
						}
					}
					.disabled(true)
				)
			}
			.font(.system(size: 22))
			.onTapGesture {
				firstResponder = .inputWord
			}
			
			Spacer()
			
			HStack {
				Button("Retry", action: {
					
				})
				.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
				.background(Color("btn-primary"))
				.foregroundColor(.white)
				.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
				.shadow(color: Color.gray, radius: 2)
				
				Button("Ranking", action: {
					
				})
				.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
				.background(Color("btn-secondary"))
				.foregroundColor(Color("btn-primary"))
				.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
				.shadow(color: Color.gray, radius: 2)
			}
			
			Spacer()
		}
	}
	
	func submitWord(word: String) {
		if word.suffix(1) == " " && word.count != 1 {
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
