//
//  SaveScoreView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 16/05/21.
//

import SwiftUI
import SlideOverCard

struct SaveScoreView: View {
	
	@EnvironmentObject private var typingVM: TypingViewModel
	@Binding var activeSlideOverCard: SlideOverCardViews?
	@StateObject private var saveScoreVM: SaveScoreViewModel
	
	init(activeSlideOverCard: Binding<SlideOverCardViews?>, userId: String) {
		self._activeSlideOverCard = activeSlideOverCard
		_saveScoreVM = StateObject(wrappedValue: SaveScoreViewModel(userId: userId))
	}
	
	var body: some View {
		VStack {
			Image("cloud")
				.resizable()
				.aspectRatio(contentMode: .fit)
			
			Text("Save the score")
				.font(.title2)
				.bold()
			
			Text("Congratulations on reaching \(typingVM.stats.correctWords) WPM!")
				.padding(.top, 10)
			
			TextField("Enter Name", text: $saveScoreVM.name)
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding(.top, 10)
				.padding(.bottom, 25)
			
			VStack {
				Button("Save") {
					saveScoreVM.saveScore(userScore: Ranking(id: typingVM.userId, user: saveScoreVM.name, wpm: typingVM.stats.correctWords, testDate: Double(Date().timeIntervalSince1970 * 1000))) {
						activeSlideOverCard = .ranking
					}
				}
				.buttonStyle(PrimaryButtonStyle())
				.disabled(saveScoreVM.name == "")
				
				Button("Back", action: {
					activeSlideOverCard = .testResult
				})
				.padding(.top, 5)
			}
		}
	}
}

struct SaveScoreView_Previews: PreviewProvider {
    static var previews: some View {
		SaveScoreView(activeSlideOverCard: .constant(.saveScore), userId: "test")
			.environmentObject(TypingViewModel())
    }
}
