//
//  ContentView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 27/03/21.
//

import SwiftUI
import MbSwiftUIFirstResponder
import SlideOverCard

struct ContentView: View {
	
	@EnvironmentObject private var typingVM: TypingViewModel
	@StateObject private var timerVM = TimerViewModel()
	@State private var activeSlideOverCard: SlideOverCardViews?
	
    var body: some View {
		VStack(alignment: .leading) {
			ScrollView {
				HStack {
					Spacer()
					Button(action: {
						timerVM.reset()
						activeSlideOverCard = .ranking
					}) {
						ZStack {
							Image(systemName: "chart.bar")
								.renderingMode(.original)
							RoundedRectangle(cornerRadius: 15, style: .continuous)
								.stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
								.frame(width: 50, height: 50)
						}
					}
				}
				.padding()
				
				HStack {
					VStack(alignment: .leading, spacing: 5) {
						Text("Typing Test")
							.font(.largeTitle)
							.fontWeight(.bold)
							.foregroundColor(Color("indigo-500"))
						Text("Test your typing skills")
							.font(.title)
					}
					Spacer()
				}
				.padding(.horizontal)
				.padding(.top, 15)
				.padding(.bottom, 25)
				
				CardView(color: Color("indigo-500")) {
					HStack {
						TimerView(timerVM: timerVM, lineWidth: 10, radius: 40, strokeColor: Color("indigo-300"), textColor: .white)
						StatsView(textColor: .white)
					}
					.frame(maxWidth: .infinity)
				}
				.padding(.horizontal)
				.padding(.vertical, 20)
				
				TypingView(timerVM: timerVM)
					.padding(.top, 50)
					.padding(.bottom, 75)
				
				Button(action: {
					typingVM.resetTypingTest()
					timerVM.reset()
				}){
					RoundedRectangle(cornerRadius: 15, style: .continuous)
						.frame(maxWidth: .infinity, minHeight: 45)
						.foregroundColor(Color("indigo-500"))
						.overlay(
							Text("Retry")
								.foregroundColor(.white)
						)
						.padding()
				}
				.buttonStyle(PlainButtonStyle())
				
				Spacer()
			}
		}
		.padding(.vertical, 0.1)
		.onReceive(timerVM.$secondsLeft) { seconds in
			if seconds == 0 {
				typingVM.saveTopWPMInUserDefaults()
				activeSlideOverCard = .testResult
			}
		}
		.slideOverCard(item: $activeSlideOverCard) { item in
			switch item {
				case .testResult:
					TestResultView(activeSlideOverCard: $activeSlideOverCard)
				case .saveScore:
					SaveScoreView(activeSlideOverCard: $activeSlideOverCard)
				case .ranking:
					RankingView(activeSlideOverCard: $activeSlideOverCard, userId: typingVM.userId)
			}
		}
		.onChange(of: activeSlideOverCard) { status in
			if status == nil {
				typingVM.resetTypingTest()
				timerVM.reset()
			}
		}
	}
}

enum SlideOverCardViews: Identifiable {
	var id: Int {
		get {
			hashValue
		}
	}
	
	case testResult
	case saveScore
	case ranking
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			.environmentObject(TypingViewModel())
    }
}
