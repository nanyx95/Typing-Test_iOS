//
//  PrimaryButtonStyle.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 04/06/21.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
	
	struct Content: View {
		
		let configuration: Configuration
		@Environment(\.isEnabled) private var isEnabled: Bool
		
		var body: some View {
			configuration.label
				.frame(maxWidth: .infinity, minHeight: 45, maxHeight: 45)
				.background(Color.accentColor)
				.foregroundColor(.white)
				.clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
				.opacity(configuration.isPressed || !isEnabled ? 0.75 : 1.0)
		}
		
	}
	
	func makeBody(configuration: Self.Configuration) -> some View {
		Content(configuration: configuration)
	}
	
}

struct PrimaryButtonStylePreview: View {
    var body: some View {
		VStack {
			Button("Save") {
				print("Hello!")
			}
			.buttonStyle(PrimaryButtonStyle())
		}
		.padding()
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
		PrimaryButtonStylePreview()
    }
}
