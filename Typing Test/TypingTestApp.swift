//
//  TypingTestApp.swift
//  Typing Test
//
//  Created by Fabio Somaglia on 27/03/21.
//

import SwiftUI

@main
struct TypingTestApp: App {
	
	@StateObject private var typingVM = TypingViewModel()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(typingVM)
        }
    }
}
