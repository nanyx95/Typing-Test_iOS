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
	@ObservedObject private var saveScoreVM = SaveScoreViewModel()
	
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
				Button(action: {
					saveScoreVM.saveScore(userScore: Ranking(id: typingVM.userId, user: saveScoreVM.name, wpm: typingVM.stats.correctWords, testDate: Double(Date().timeIntervalSince1970 * 1000))) {
						activeSlideOverCard = .ranking
					}
				}){
					RoundedRectangle(cornerRadius: 15, style: .continuous)
						.frame(maxWidth: .infinity, maxHeight: 45)
						.foregroundColor(Color("indigo-500"))
						.overlay(
							Text("Save")
								.foregroundColor(.white)
						)
				}
				.buttonStyle(PlainButtonStyle())
				
				Button("Back", action: {
					activeSlideOverCard = .testResult
				})
			}
		}
	}
}

struct SaveScoreView_Previews: PreviewProvider {
    static var previews: some View {
		SaveScoreView(activeSlideOverCard: .constant(.saveScore))
			.environmentObject(TypingViewModel())
    }
}
