//
//  StatsView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 26/04/21.
//

import SwiftUI

struct StatsView: View {
	
	@ObservedObject var typingVM: TypingViewModel
	var textColor: Color = .black
	private let items: [GridItem] = Array(repeating: .init(.flexible(minimum: 100)), count: 2)
	
    var body: some View {
		LazyVGrid(columns: items, spacing: 10) {
			VStack {
				Text(String(typingVM.stats.correctWords))
					.font(.title)
				Text("words/min")
					.font(.caption)
					.fontWeight(.light)
					.textCase(.uppercase)
			}
			VStack {
				Text(String(typingVM.stats.correctChars))
					.font(.title)
				Text("chars/min")
					.font(.caption)
					.fontWeight(.light)
					.textCase(.uppercase)
			}
			VStack {
				Text(String(typingVM.stats.accuracy))
					.font(.title)
				Text("% accuracy")
					.font(.caption)
					.fontWeight(.light)
					.textCase(.uppercase)
			}
			VStack {
				Text("37")
					.font(.title)
				Text("top words/min")
					.font(.caption)
					.fontWeight(.light)
					.textCase(.uppercase)
			}
		}
		.foregroundColor(textColor)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(typingVM: TypingViewModel())
    }
}
