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
	@State private var bouncing = false
	
    var body: some View {
		let tfBinding = Binding<String>(
			get: { typingVM.textFieldValue },
			set: { newValue in
				if timerVM.timerMode != .running {
					timerVM.start()
				}
				typingVM.evaluateKeypress(word: newValue)
			}
		)
		
		VStack {
			if firstResponder == nil {
				VStack(spacing: 5) {
					Text("Start typing")
					Image(systemName: "arrow.down")
				}
				.offset(y: bouncing ? -15 : -25)
				.animation(.easeInOut(duration: 1).repeatForever(autoreverses: true))
				.onAppear() {
					self.bouncing.toggle()
				}
			}
			
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
				
				TextField(" ", text: tfBinding, onCommit: { firstResponder = nil })
					.firstResponder(id: FirstResponders.inputWord, firstResponder: $firstResponder, resignableUserOperations: .all)
					.disableAutocorrection(true)
					.autocapitalization(.none)
					.foregroundColor(.white)
					.accentColor(.primary)
					.lineLimit(1)
					.frame(width: 1, height: 0)
				
				Spacer().overlay(
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							ForEach(typingVM.words, id: \.id) { word in
								Text(word.word)
									.font(.system(size: 25, design: .monospaced))
									.tracking(-1)
									.padding(-1.0)
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
		.transition(.slide)
		.animation(.easeInOut, value: firstResponder)
    }
}

struct TypingView_Previews: PreviewProvider {
    static var previews: some View {
		TypingView(timerVM: TimerViewModel())
			.environmentObject(TypingViewModel())
    }
}
