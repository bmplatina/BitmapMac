//
//  ContentView.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/13.
//

import SwiftUI
import WebKit


struct Option: Hashable {
    let title: String
    let imageName: String
}

struct ContentView: View {
    @State var currentOption = 0
    let options: [Option] = [
        .init(title: "Home", imageName: "house"),
        .init(title: "Games", imageName: "gamecontroller.fill"),
        .init(title: "Settings", imageName: "gear"),
        .init(title: "Accounts", imageName: "person.badge.key"),
    ]
    
    var body: some View {
        /* VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        } */
        NavigationView {
            ListView(
                currentSelection: $currentOption,
                options: options
            )
            switch currentOption {
            case 1:
                Text("About Bitmap Store")
            default:
                MainView()
            }
        }
        .frame(minWidth: 600, minHeight: 400 )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ListView: View {
    @Binding var currentSelection: Int
    let options: [Option]
    var body: some View {
        VStack() {
            let current = options[currentSelection]
            ForEach(options, id: \.self) { option in
                HStack {
                    Image(systemName: option.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    Text(option.title)
                        .foregroundColor(current == option ? Color.blue: Color.white)
                    Spacer()
                }
                .padding(8)
                .onTapGesture {
                    if currentSelection == 1 {
                        currentSelection = 0
                    }
                    else {
                        self.currentSelection = 1
                    }
                }
            }
            Spacer()
        }
    }
}

struct MainView: View {
    var body: some View {
        VStack {
            Image("header")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }
    }
}
