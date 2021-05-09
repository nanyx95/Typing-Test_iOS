//
//  StatsView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 26/04/21.
//

import SwiftUI

struct StatsView: View {
	
	var textColor: Color
	private var items: [GridItem] = Array(repeating: .init(.flexible(minimum: 100)), count: 2)
	
	init(textColor: Color = .black) {
		self.textColor = textColor
	}
	
    var body: some View {
		LazyVGrid(columns: items, spacing: 10) {
			VStack {
				Text("30")
					.font(.title)
				Text("words/min")
					.font(.caption)
					.fontWeight(.light)
					.textCase(.uppercase)
			}
			VStack {
				Text("80")
					.font(.title)
				Text("chars/min")
					.font(.caption)
					.fontWeight(.light)
					.textCase(.uppercase)
			}
			VStack {
				Text("100")
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
        StatsView()
    }
}
