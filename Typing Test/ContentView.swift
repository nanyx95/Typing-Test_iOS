//
//  ContentView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 27/03/21.
//

import SwiftUI
import MbSwiftUIFirstResponder

struct ContentView: View {
	
	@StateObject private var typingVM = TypingViewModel()
	
	enum FirstResponders: Int {
		case inputWord
	}
	@State var firstResponder: FirstResponders? = nil
	
    var body: some View {
		let binding = Binding<String>(
			get: { typingVM.textFieldValue },
			set: { newValue in
				print("char \(newValue)")
//				if newValue.suffix(1) == " " {
//					print("spazio")
//					typingVM.onInput(word: newValue, isSpace: true)
//				} else if newValue == String(typingVM.textFieldValue.dropLast()) {
//					print("backspace")
//					typingVM.onInput(word: newValue, isBackspace: true)
//				} else {
//					print("lettera normale")
//					typingVM.onInput(word: newValue)
//				}
				typingVM.evaluateKeypress(word: newValue)
			}
		)
		
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
			
			Text("Timer and stats placeholder")
			
			Spacer()
			
			HStack {
				Spacer().overlay(
					HStack {
						ScrollView(.horizontal, showsIndicators: false) {
							HStack {
								ForEach(typingVM.typedWords, id: \.id) { word in
									Text(word.word)
										.strikethrough(word.isCorrect ? false : true)
										.foregroundColor(Color("typed-words"))
										.padding(-1.0)
								}
								Text(typingVM.textFieldValue)
									.strikethrough(typingVM.flagWrongWord ? true : false)
									.foregroundColor(Color("current-word"))
									.padding(-1.0)
									
							}
							.rotationEffect(.degrees(180))
						}
						.disabled(true)
						.rotationEffect(.degrees(180))
					}
				)
				
				TextField(" ", text: binding, onCommit: { firstResponder = nil })
					.firstResponder(id: FirstResponders.inputWord, firstResponder: $firstResponder, resignableUserOperations: .all)
					.disableAutocorrection(true)
					.autocapitalization(.none)
					.foregroundColor(.white)
					.accentColor(.black)
					.lineLimit(1)
	//				.border(Color.black)
					.frame(width: 1, height: 0)
//					.onChange(of: typingVM.textFieldValue) {
//						submitWord(word: $0)
//					}
				
				Spacer().overlay(
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							ForEach(typingVM.words, id: \.id) { word in
								Text(word.word)
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
		.onAppear {
			typingVM.getWords(number: 10)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
