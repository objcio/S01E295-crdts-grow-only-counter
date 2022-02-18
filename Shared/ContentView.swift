//
//  ContentView.swift
//  Shared
//
//  Created by Chris Eidhof on 10.02.22.
//

import SwiftUI
import CRDTs

struct SessionView: View {
    @StateObject private var session = Session<GCounter<Int>>()
    @Binding var counter: GCounter<Int>

    var body: some View {
        Circle().frame(width: 20, height: 20)
            .foregroundColor(session.connected ? .green : .red)
            .onChange(of: counter) { newValue in
                try! session.send(newValue)
            }
            .onChange(of: session.connected) { _ in
                try! session.send(counter)
            }
            .task {
                for await newValue in session.receiveStream {
                    counter.merge(newValue)
                }
            }
    }
}

struct ContentView: View {
    @State var int = GCounter<Int>(0)
    @State var online = true
    
    var body: some View {
        VStack {
            if online {
                SessionView(counter: $int)
            }
            Text("\(int.value)")
            Button("Increment") { int += 1 }
        }
        .fixedSize()
        .padding(30)
        
        .toolbar {
            Toggle("Online", isOn: $online)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
