//
//  CardView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 09/05/21.
//

import SwiftUI

struct CardView<Content: View>: View {
	
	let content: Content
	let color: Color
		
	init(color: Color = .white, @ViewBuilder content: () -> Content) {
		self.color = color
		self.content = content()
	}
	
    var body: some View {
		VStack {
			content
		}
		.padding()
		.background(color)
		.cornerRadius(20)
		.shadow(color: color.opacity(0.5), radius: 20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
		CardView() {
			Text("I'm inside a card!")
			Image(systemName: "hand.thumbsup")
		}
    }
}
