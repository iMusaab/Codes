import SwiftUI

struct Category: Hashable {
    var title: String
    var icon: String?
}

struct CategoriesScrollView: View {
    @Binding var selectedCategory: String
    
    var catigories: [Category] = []
    @State private var chosenCategoryHashValue: Int?
    
    init(selectedCategory: Binding<String>) {
        catigories.append(Category(title: "الكل", icon: nil))
        catigories.append(Category(title: "الجمال والعطور", icon: "perfumePic"))
        catigories.append(Category(title: "المتاجر الكبرى", icon: nil))
        catigories.append(Category(title: "تطبيقات التوصيل", icon: nil))
        catigories.append(Category(title: "إلكترونيات", icon: nil))
        catigories.append(Category(title: "سفر", icon: nil))
        
        self._selectedCategory = selectedCategory
        
        
    }
    
    var body: some View {
        
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    HStack(alignment: .center, spacing: 10) {
                        ForEach(catigories, id: \.self) { category in
                            Button(action: {
                                
                                chosenCategoryHashValue = category.hashValue
                                selectedCategory = category.title
                                
                            }, label: {
                                HStack(spacing: 5) {
                                    if let icon = category.icon {
                                        Image(icon)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15, alignment: .center)
                                    }
                                    Text(category.title).fixedSize()
                                        .font(.footnote)
                                        .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                    
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 8)
                                .background(chosenCategoryHashValue == category.hashValue ? Color(#colorLiteral(red: 0.8078431373, green: 0.8156862745, blue: 0.8078431373, alpha: 1)) : Color.clear)
                                .cornerRadius(11)
                                
                            })
                            
                            
                        }
                    }.padding(.horizontal)
                    .onAppear {
                        chosenCategoryHashValue = catigories[0].hashValue
                        value.scrollTo(catigories[catigories.startIndex])
                    }
                }
                
                
            }
        }
    }
}


struct CategoriesScrollView_Previews: PreviewProvider {
    @State static var selectedCategory = "الكل"
    static var previews: some View {

        CategoriesScrollView(selectedCategory: $selectedCategory)
            .environment(\.layoutDirection, .rightToLeft)
    }
}

