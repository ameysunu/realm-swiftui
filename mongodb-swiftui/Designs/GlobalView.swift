//
//  GlobalView.swift
//  mongodb-swiftui
//
//  Created by Amey Sunu on 18/07/21.
//

import SwiftUI

struct GlobalView: View {
    
    @State var name:String?
    @State var date: String?
    @State var title:String?
    @State var mood:String?
    @State var value:String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color("#CBCCFF"))
            HStack {
                VStack(alignment: .leading){
                    Spacer()
                    Text(date!)
                        .foregroundColor(Color("#914275"))
                    Text(title!)
                        .foregroundColor(.black)
                        .font(.title)
                    Text("By: \(name!)")
                        .font(.title2)
                        .foregroundColor(Color("#9496C6"))
                    Spacer()
                    
                }
                .padding()
                Spacer()
                
            }
        }
    }
}

struct GlobalView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalView().previewLayout(.fixed(width: 300, height: 200))
    }
}
