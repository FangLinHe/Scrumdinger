//
//  TranscriptionView.swift
//  Scrumdinger
//
//  Created by FANG-LIN HE on 16.02.2024.
//

import SwiftUI

struct TranscriptionView: View {
    @StateObject var speechRecognizer: SpeechRecognizer = SpeechRecognizer()

    var body: some View {
        VStack {
            Text("Transcript")
                .font(.headline)
                .padding(.top)
            HStack {
                Text(speechRecognizer.transcript)
                    .lineLimit(1, reservesSpace: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .truncationMode(.head)
                    .padding(.bottom)
                    .font(.caption)
            }
        }
        .padding([.vertical, .horizontal])
    }
}

#Preview {
    TranscriptionView()
}
