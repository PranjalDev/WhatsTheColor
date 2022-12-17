import SwiftUI

struct GroupedGridView<Data, ID, Content, Title>: View where Data : RandomAccessCollection, ID : Hashable, Content : View, Title: StringProtocol {
    
    let data: Data
    let id: KeyPath<Data.Element, ID>
    let gridColumCount: Int
    let title: Title
    let content: (Data.Element) -> Content
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
        
    var body: some View {
        GroupBox(
            label: Text(title)
                .font(.title)
        ) {
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(
                        alignment: .top
                    ),
                    count: horizontalSizeClass == .regular ? 3 : 1
                )
            ) {
                ForEach(
                    data,
                    id: id
                ) { result in
                    GroupBox {
                        content(result)
                    }
                }
            }
        }
        
    }
}
