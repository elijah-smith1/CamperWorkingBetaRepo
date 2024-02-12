import SwiftUI

struct Social: View {
    let categories = ["Events", "Trending", "Spotlight", "Bulletin Board"]
    @State private var selectedCategoryIndex = 0
    @State private var showingSearchView = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    categoryPicker
                    contentSwitcherView
                }
                .padding(.bottom, 20)
            }
            .navigationTitle(categories[selectedCategoryIndex])
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink(destination: Messages()) {
                        Image(systemName: "message")
                    }
                }

                ToolbarItem(placement: .principal) {
                    Button(action: {
                        showingSearchView = true
                    }) {
                        HStack {
                            Text("Search...")
                                .foregroundColor(.blue)
                        }
                        .padding(7)
                        .frame(width: 300, height: 30)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.blue))
                    }
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NotificationsView()) {
                        Image(systemName: "bell")
                    }
                }
            }
            .sheet(isPresented: $showingSearchView) {
                Search() // Ensure this view exists and is correct
            }
        }
    }

    var categoryPicker: some View {
        Picker("Categories", selection: $selectedCategoryIndex) {
            ForEach(categories.indices, id: \.self) { index in
                Text(categories[index]).tag(index)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
    
    var contentSwitcherView: some View {
        Group {
            switch selectedCategoryIndex {
            case 0:
                Events()
            case 1:
                Trending() // Replace with your actual view for Trending
            case 2:
                Spotlight() // Replace with your actual view for Spotlight
            case 3:
                BulletinBoard() // Replace with your actual view for Bulletin Board
            default:
                EmptyView()
            }
        }
    }
    struct TabsView: View {
        let tabs: [String]
        @Binding var selectedTabIndex: Int
        
        var body: some View {
            HStack(spacing: 20) {
                ForEach(tabs.indices) { index in
                    Text(tabs[index])
                        .foregroundColor(index == selectedTabIndex ? .blue : .black)
                        .underline(index == selectedTabIndex ? true : false, color: .blue)
                        .padding(.vertical, 10)
                        .onTapGesture {
                            withAnimation {
                                selectedTabIndex = index
                            }
                        }
                }
            }
        }
    }
}
struct Social_Previews: PreviewProvider {
    static var previews: some View {
        Social()
    }
}
