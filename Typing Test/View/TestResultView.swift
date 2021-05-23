//
//  TestResultView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 16/05/21.
//

import SwiftUI
import SlideOverCard

struct TestResultView: View {
	
	@Binding var activeSlideOverCard: SlideOverCardViews?
	
    var body: some View {
		VStack {
			Text("Test result")
			VStack {
//				Button("Do something", action: {
//					activeSlideOverCard = .saveScore
//				}).buttonStyle(SOCActionButton())
				Button(action: {
					activeSlideOverCard = .saveScore
				}){
					RoundedRectangle(cornerRadius: 15, style: .continuous)
						.frame(maxWidth: .infinity, maxHeight: 45)
						.foregroundColor(Color("indigo-500"))
						.overlay(
							Text("Save the score")
								.foregroundColor(.white)
						)
				}
				.buttonStyle(PlainButtonStyle())
			}
		}
    }
}

struct TestResultView_Previews: PreviewProvider {
    static var previews: some View {
		TestResultView(activeSlideOverCard: .constant(.testResult))
    }
}
