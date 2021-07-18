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
                }
                .padding()
                Spacer()
                
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().previewLayout(.fixed(width: 300, height: 200))
    }
}
