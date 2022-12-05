

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        ZStack(alignment: .center) {

            self.content()
                .disabled(self.isShowing)
            HStack {
                ActivityIndicator(isAnimating: .constant(true), style: .large)
                Text("Loading...")
                    .fontWeight(.semibold)
                    .padding(.leading, 15)
            }
            .frame(width: 200,
                   height: 70)
            .background(Color.white)
            .cornerRadius(20)
            .opacity(self.isShowing ? 1 : 0)
        }
    }

}
