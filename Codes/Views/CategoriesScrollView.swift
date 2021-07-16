import SwiftUI

struct Category: Hashable {
    var title: String
    var icon: String?
}

struct CategoriesScrollView: View {
    @Binding var selectedCategory: String
    @Binding var isSearching: Bool
    var catigories: [Category] = []
    @State private var chosenCategoryHashValue: Int?
    
    init(selectedCategory: Binding<String>, isSearching: Binding<Bool>) {
        catigories.append(Category(title: "الأشهر", icon: "PopularPic"))
        catigories.append(Category(title: "الأزياء", icon: "DressPic"))
        catigories.append(Category(title: "تطبيقات التوصيل", icon: "DelivryPic"))
        catigories.append(Category(title: "الأحذية", icon: "ShoesPic"))
        catigories.append(Category(title: "الجمال والعطور", icon: "perfumePic"))
        catigories.append(Category(title: "صحة", icon: "HealthPic"))
        catigories.append(Category(title: "المتاجر الكبرى", icon: "StorePic"))
        catigories.append(Category(title: "إلكترونيات", icon: "PlugPic"))
        catigories.append(Category(title: "أطفال", icon: "KidPic"))
        catigories.append(Category(title: "سفر", icon: "TravelPic"))
        catigories.append(Category(title: "أخرى", icon: nil))
        
        self._selectedCategory = selectedCategory
        
        self._isSearching = isSearching
        
        
    }
    
    var body: some View {
        
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    HStack(alignment: .center, spacing: 2) {
                        ForEach(catigories, id: \.self) { category in
                            Button(action: {
                                
                                chosenCategoryHashValue = category.hashValue
                                selectedCategory = category.title
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                isSearching = false
                                
                            }, label: {
                                HStack(spacing: 5) {
                                    if let icon = category.icon {
                                        Image(icon)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: category == catigories[3] ? 18 : 15, height: 15, alignment: .center)
                                    }
                                    Text(category.title)
                                        .font(.footnote).bold()
                                        .fixedSize()
                                        .foregroundColor(Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)))
                                    
                                }
                                .padding(.vertical, 7)
                                .padding(.horizontal, 8)
                                .background(chosenCategoryHashValue == category.hashValue ? Color(#colorLiteral(red: 0.8078431373, green: 0.8156862745, blue: 0.8078431373, alpha: 1)) : Color.clear)
                                .cornerRadius(11)
                                .padding(.top, 10)
                                
                            })
                            
                            
                        }
                    }
                    
                    .onAppear {
                        if chosenCategoryHashValue == nil {
                            chosenCategoryHashValue = catigories[0].hashValue
                            value.scrollTo(catigories[catigories.startIndex])
                        } else {
                            
                            if let category = catigories.first( where: { $0.title.contains(selectedCategory)
                            }) {
                                chosenCategoryHashValue = category.hashValue
                                value.scrollTo(category)
                            }
                        }
                        
                        //
                        
                    }
                }
                
                
            }
            .padding(.horizontal, 7)
        }
    }
}


struct CategoriesScrollView_Previews: PreviewProvider {
    @State static var selectedCategory = "الكل"
    @State static var isSearching = false
    static var previews: some View {

        CategoriesScrollView(selectedCategory: $selectedCategory, isSearching: $isSearching)
            .environment(\.layoutDirection, .rightToLeft)
    }
}

