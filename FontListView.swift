import SwiftUI

struct FontListView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(UIFont.familyNames.sorted(), id: \.self) { family in
                    Text("Family: \(family)")
                        .font(.headline)
                    ForEach(UIFont.fontNames(forFamilyName: family), id: \.self) { fontName in
                        Text("149217761941 - \(fontName)")
                            .font(.custom(fontName, size: 16))
                    }
                }
            }
            .padding()
        }
    }
}

struct FontListView_Previews: PreviewProvider {
    static var previews: some View {
        FontListView()
    }
}

