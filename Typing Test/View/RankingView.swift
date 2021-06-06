//
//  RankingView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 15/05/21.
//

import SwiftUI
import SlideOverCard

struct RankingView: View {
	
	@EnvironmentObject private var typingVM: TypingViewModel
	@Binding var activeSlideOverCard: SlideOverCardViews?
	@ObservedObject private var rankingVM: RankingViewModel
	
	init(activeSlideOverCard: Binding<SlideOverCardViews?>, userId: String) {
		self._activeSlideOverCard = activeSlideOverCard
		self.rankingVM = RankingViewModel(userId: userId)
	}
	
	#if DEBUG
	init(forPreview: Bool, activeSlideOverCard: Binding<SlideOverCardViews?>, userId: String) {
		self._activeSlideOverCard = activeSlideOverCard
		self.rankingVM = RankingViewModel(userId: userId)
		self.rankingVM.mockRankingForPreview()
	}
	#endif
	
	var body: some View {
		VStack {
			Image("cup")
				.resizable()
				.aspectRatio(contentMode: .fit)
			
			Text("Ranking")
				.font(.title2)
				.bold()
			
			VStack {
				if rankingVM.isLoading {
					ProgressView()
						.progressViewStyle(CircularProgressViewStyle(tint: Color("indigo-500")))
				} else {
					ForEach(rankingVM.rankingToDisplay.indices, id: \.self) { index in
						let user = rankingVM.rankingToDisplay[index]
						if typingVM.userId.caseInsensitiveCompare(user.id) == .orderedSame {
							RankingCell(position: rankingVM.userPosition!, user: user.user, wpm: user.wpm, date: user.testDate, highlightsCell: true)
						} else {
							RankingCell(position: index + 1, user: user.user, wpm: user.wpm, date: user.testDate, highlightsCell: false)
						}
					}
				}
			}
			.padding(.horizontal, 5)
			.padding(.top, 10)
			.padding(.bottom, 25)

			Button("Close") {
				activeSlideOverCard = nil
			}
			.buttonStyle(PrimaryButtonStyle())
		}
	}
}

struct RankingCell: View {
	
	var position: Int
	var user: String
	var wpm: Int
	var date: Double
	var highlightsCell: Bool
	
	static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd/MM/yyyy"
		return formatter
	}()
	
	var body: some View {
		HStack(alignment: .center, spacing: 15) {
			ZStack {
				if highlightsCell {
					Circle()
						.fill(Color("indigo-500"))
					
					Text("\(position)")
						.font(.callout)
						.foregroundColor(.white)
				} else {
					Circle()
						.strokeBorder(Color("indigo-500"), style: StrokeStyle(lineWidth: 1.5))
					
					Text("\(position)")
						.font(.callout)
				}
			}
			.frame(width: 40, height: 40, alignment: .center)
			
			VStack(alignment: .leading, spacing: 0) {
				HStack(alignment: .center) {
					Text(user)
						.font(.title3)
					Spacer()
					Text(Date(timeIntervalSince1970: date / 1000), formatter: Self.dateFormatter)
						.font(.caption)
						.foregroundColor(.gray)
				}
				WPMPill(wpm: wpm)
					.padding(.vertical, 5)
			}
		}
	}
}

struct WPMPill: View {
	
	var wpm: Int
	var fontSize: CGFloat = 12.0
	
	var body: some View {
		ZStack {
			Text("\(wpm) WPM")
				.font(.system(size: fontSize, weight: .regular))
				.foregroundColor(.white)
				.padding(5)
				.background(Color("indigo-500").opacity(0.7))
				.cornerRadius(5)
		}
	}
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
		RankingView(forPreview: true, activeSlideOverCard: .constant(.ranking), userId: "test")
			.environmentObject(TypingViewModel())
			.padding()
			.previewLayout(.sizeThatFits)
    }
}
