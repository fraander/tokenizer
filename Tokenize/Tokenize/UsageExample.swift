//
//  ContentView.swift
//  Tokenize
//
//  Created by Frank Anderson on 12/18/22.
//

import SwiftUI

struct UsageExample: View {
    
    @State var tokens = ["#", "$", "%", "@", "&", "*"]
    @State var tokenChoice = "#"
    @State var input = "This is an #example input. #token \\#ignoreTheToken"
    
    var tokenPicker: some View {
        Picker("Token", selection: $tokenChoice) {
            ForEach(tokens, id: \.self) { token in
                Text(token)
            }
        }
        .pickerStyle(.segmented)
    }
    
    var inputField: some View {
        TextField("Type something you want tokenized", text: $input)
    }
    
    var tokenized: (String, Set<String>) {
        input.tokenize(with: tokens.first(where: { token in
            tokenChoice == token
        }) ?? "#")
    }
    
    var contentDisplay: some View {
        Group {
            if tokenized.0.count == 0 {
                Text("There's nothing to evaluate yet.")
                    .foregroundColor(.secondary)
            } else {
                Text(tokenized.0)
            }
        }
    }
    
    var tokenDisplay: some View {
        Group {
            if tokenized.1.sorted().count == 0 {
                Text("No tokens found yet.")
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(tokenized.1.sorted(), id: \.self) { item in
                            Text(item)
                                .foregroundColor(.white)
                                .padding(4)
                                .background {
                                    Capsule()
                                        .fill(Color.secondary)
                                }
                                .transition(.scale.combined(with: .opacity.combined(with: .move(edge: .leading))))
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            tokenPicker
            
            inputField
            
            Divider()
            
            contentDisplay
                .frame(maxWidth: .infinity, alignment: .leading)
            
            tokenDisplay
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(.easeInOut, value: tokenized.1)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UsageExample()
    }
}
