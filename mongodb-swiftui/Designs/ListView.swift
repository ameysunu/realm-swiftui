//
//  ListView.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 18/07/21.
//

import SwiftUI

struct ListView: View {
    
    @State var date:String?
    @State var title:String?
    @State var mood:String?
    @State var value:String?
    @State var isPublic: String?
    @State var isOpen: Bool = false
    @State var isToggled: Bool = false
    @State var functionEnabled: Bool = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.gray)
            HStack {
                VStack(alignment: .leading){
                    Spacer()
                    Text(date!)
                        .foregroundColor(.black)
                    Text(title!)
                        .foregroundColor(.black)
                        .font(.title)
                    Text(mood!)
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    if(isOpen == true){
                        Text(value!)
                            .foregroundColor(.black)
                    }
                    if(functionEnabled == true) {
                        HStack {
                            Spacer()
                            Button(action:{
                                self.isToggled.toggle()
                            }) {
                                Text("Edit")
                                    .foregroundColor(Color("#914275"))
                                    .padding(.trailing, 5)
                            }
                            Image(systemName: buttonValue)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    isOpen.toggle()
                                }
                        }
                    }
                    
                }
                .padding()
                Spacer()
                
            }
            .sheet(isPresented: $isToggled){
                Diaries(title: title!, mood: mood!, main: value! ,isPresented: $isToggled, noChecked: Bool(isPublic!)!, updateTriggered: true )
            }
        }
    }
    
    var buttonValue: String {
        return isOpen ? "chevron.up.circle.fill" : "chevron.down.circle.fill"
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().previewLayout(.fixed(width: 300, height: 200))
    }
}
