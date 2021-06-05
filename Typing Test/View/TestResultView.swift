//
//  TestResultView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 16/05/21.
//

import SwiftUI
import SlideOverCard

struct TestResultView: View {
	
	@EnvironmentObject private var typingVM: TypingViewModel
	@Binding var activeSlideOverCard: SlideOverCardViews?
	
	@ViewBuilder fileprivate func resultContent(image: String, title: String, text1: String, text2: String) -> some View {
		Image("\(image)")
			.resizable()
			.aspectRatio(contentMode: .fit)
//			.padding(.horizontal)
		
		Text("\(title)")
			.font(.title2)
			.bold()
		
		Group {
			Text("\(text1) You type with the speed of ") +
			Text("\(typingVM.stats.correctWords) WPM ")
				.foregroundColor(Color("indigo-500"))
				.bold() +
			Text("(\(typingVM.stats.correctChars) CPM). Your accuracy was ") +
			Text("\(typingVM.stats.accuracy)%")
				.bold() +
			Text(". \(text2)")
		}
		.multilineTextAlignment(.center)
		.padding(.top, 10)
		.padding(.bottom, 25)
	}
	
	var body: some View {
		VStack {
			if typingVM.stats.correctWords < 30 {
				resultContent(image: "typewriter", title: "Keep practicing!", text1: "Well...", text2: "It could be better!")
			} else {
				resultContent(image: "rocket", title: "You're a Rocket!", text1: "Nice!", text2: "Keep practicing!")
			}
			
			Button("Save the score") {
				activeSlideOverCard = .saveScore
			}
			.buttonStyle(PrimaryButtonStyle())
		}
    }
}

struct TestResultView_Previews: PreviewProvider {
    static var previews: some View {
		TestResultView(activeSlideOverCard: .constant(.testResult))
			.environmentObject(TypingViewModel())
    }
}
