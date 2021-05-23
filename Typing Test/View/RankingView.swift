//
//  RankingView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 15/05/21.
//

import SwiftUI
import SlideOverCard

struct RankingView: View {	
	var body: some View {
		VStack(alignment: .center, spacing: 25) {
			VStack {
				Text("Large title").font(.system(size: 28, weight: .bold))
				Text("A nice and brief description")
			}
			
			ZStack {
				RoundedRectangle(cornerRadius: 25.0, style: .continuous).fill(Color.gray)
				Text("Content").foregroundColor(.white)
			}
		}
		.frame(height: 480)
	}
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
		RankingView()
    }
}
