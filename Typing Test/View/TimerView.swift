//
//  TimerView.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 25/04/21.
//

import SwiftUI

struct TimerView: View {
	
	@ObservedObject var timerVM: TimerViewModel
	var lineWidth: CGFloat = 15
	var radius: CGFloat = 50
	var strokeColor: Color = Color("subtitle")
	var textColor: Color = .black
	
    var body: some View {
		ZStack {
			Circle()
				.stroke(strokeColor.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
			Circle()
				.trim(from: 0, to:  1 - CGFloat(timerVM.defaultTimeRemainig - timerVM.secondsLeft) / CGFloat(timerVM.defaultTimeRemainig))
				.stroke(strokeColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
				.rotationEffect(.degrees(-90))
				.animation(.linear(duration: 1), value: timerVM.secondsLeft)
			Text("\(timerVM.secondsLeft)")
				.font(.largeTitle)
				.foregroundColor(textColor)
		}
		.frame(width: radius * 2, height: radius * 2)
		.padding(lineWidth / 2)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timerVM: TimerViewModel())
    }
}
