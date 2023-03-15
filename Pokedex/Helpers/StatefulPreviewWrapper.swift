//
//  StatefulPreviewWrapper.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 15/03/23.
//

import SwiftUI

import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content
    
    public var body: some View {
        content($value)
    }
    
    public init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}
