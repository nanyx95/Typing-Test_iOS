//
//  TypingView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 15/05/21.
//

import SwiftUI

struct TypingView: View {
	
	@EnvironmentObject private var typingVM: TypingViewModel
	@ObservedObject var timerVM: TimerViewModel
	
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
				if timerVM.timerMode != .running {
					timerVM.start()
				}
				typingVM.evaluateKeypress(word: newValue)
			}
		)
		
		HStack {
			Spacer().overlay(
				HStack {
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							ForEach(typingVM.typedWords, id: \.id) { word in
								Text(word.word)
									.font(.system(size: 25, design: .monospaced))
									.tracking(-1)
									.strikethrough(word.isCorrect ? false : true)
									.foregroundColor(Color("typed-words"))
									.padding(-1.0)
							}
							Text(typingVM.textFieldValue)
								.font(.system(size: 25, design: .monospaced))
								.tracking(-1)
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
								.font(.system(size: 25, design: .monospaced))
								.tracking(-1)
								.padding(-1.0)
//								.frame(width: .infinity, alignment: .leading)
						}
						.redacted(reason: typingVM.isLoading ? .placeholder : [])
					}
				}
				.disabled(true)
			)
		}
		.font(.system(size: 22))
		.onTapGesture {
			firstResponder = .inputWord
		}
		.onReceive(timerVM.$secondsLeft) { seconds in
			if seconds == 0 {
				firstResponder = nil
			}
		}
    }
}

struct TypingView_Previews: PreviewProvider {
    static var previews: some View {
        TypingView(timerVM: TimerViewModel())
			.environmentObject(TypingViewModel())
    }
}
