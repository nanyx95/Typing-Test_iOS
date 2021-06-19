//
//  TimerViewModel.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 25/04/21.
//

import SwiftUI

class TimerViewModel: ObservableObject {
	
	let defaultTimeRemainig = 60
	@Published var timerMode: TimerMode
	@Published var secondsLeft: Int
	
	var timer = Timer()
	
	init() {
		timerMode = .initial
		secondsLeft = defaultTimeRemainig
	}
	
	func start() {
		timerMode = .running
		timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
			if self.secondsLeft == 0 {
				self.reset()
			} else {
				self.secondsLeft -= 1
			}
		})
	}
	
	func reset() {
		self.timerMode = .initial
		self.secondsLeft = defaultTimeRemainig
		timer.invalidate()
	}
	
	func pause() {
		self.timerMode = .paused
		timer.invalidate()
	}
	
}

enum TimerMode {
	case initial
	case running
	case paused
}
