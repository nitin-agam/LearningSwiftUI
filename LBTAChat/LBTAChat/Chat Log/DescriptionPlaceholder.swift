//
//  DescriptionPlaceholder.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 11/09/25.
//

import SwiftUI

struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Enter message..")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}

#Preview {
    DescriptionPlaceholder()
}
