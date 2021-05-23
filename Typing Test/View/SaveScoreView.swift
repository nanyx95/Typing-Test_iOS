//
//  SaveScoreView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 16/05/21.
//

import SwiftUI
import SlideOverCard

struct SaveScoreView: View {
	
	@Binding var activeSlideOverCard: SlideOverCardViews?
	@State private var name: String = ""
	
	var body: some View {
		VStack {
			Text("Save the score")
			TextField("Nome", text: $name)
			VStack {
				Button(action: {
					activeSlideOverCard = .ranking
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
    }
}
