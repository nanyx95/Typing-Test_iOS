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
		
		
		VStack(alignment: .leading) {
			ScrollView {
				HStack {
					Spacer()
					Button(action: {
						print("Rank")
					}) {
						ZStack {
							Image(systemName: "chart.bar")
								.renderingMode(.original)
							RoundedRectangle(cornerRadius: 15, style: .continuous)
								.stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
								.frame(width: 50, height: 50)
						}
					}
				}
				.padding()
				
				HStack {
					VStack(alignment: .leading, spacing: 5) {
						Text("Typing Test")
							.font(.largeTitle)
							.fontWeight(.semibold)
						Text("Test your typing skills")
							.font(.title)
					}
					Spacer()
				}
				.padding([.horizontal, .bottom])
				
				CardView(color: Color("indigo-500")) {
					HStack {
						TimerView(lineWidth: 10, radius: 40, strokeColor: Color("indigo-300"), textColor: .white)
						StatsView(textColor: .white)
					}
					.frame(maxWidth: .infinity)
				}
				.padding()
				
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
				.padding(.vertical, 50)
				.font(.system(size: 22))
				.onTapGesture {
					firstResponder = .inputWord
				}
				
				Button("Retry", action: {
					print("Retry")
				})
				.frame(maxWidth: .infinity, minHeight: 45)
				.background(Color("indigo-500"))
				.foregroundColor(.white)
				.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
				.padding()
				
				Spacer()
			}
			
		}
		.padding(.vertical, 0.1)
		.onAppear {
//			typingVM.getWords(number: 10)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
