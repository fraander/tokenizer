//
//  TokenizeFunc.swift
//  Tokenize
//
//  Created by Frank Anderson on 12/18/22.
//

import Foundation

extension String {
    /// Function that takes a String input and converts it into content with tokenized elements removed and moved elsewhere.
    /// - Parameters:
    ///   - token: The indicator used in the string to delineate the location of tokens
    ///   - ignore: The character which indicates a token should be ignored
    /// - Returns: A tuple containing the string without tokens, and a Set of the located tokens (so as to remove duplicated tokens)
    /// - Future: (A feature to add in the future) Accept multiple tokens and return a map of results for each of the given tokens
    func tokenize(with token: String = "#", ignore: String = "\\") -> (String, Set<String>) {
        let components = self.components(separatedBy: " ")
        var tags: Set<String> = []
        var contents: [String] = []
        
        components.forEach { component in
            if (component.starts(with: token)) {
                var raw = Array(component)
                raw.removeAll { char in
                    String(char) == token
                }
                if !raw.isEmpty {
                    tags.insert(String(raw))                    
                }
            } else {
                if (component.hasPrefix(ignore + token)) {
                    var out = component
                    out.removeFirst()
                    contents.append(out)
                } else {
                    contents.append(component)                    
                }
            }
        }
        
        var stringify: String = contents.reduce("") { soFar, current in
            soFar + " " + current
        }
        
        if stringify.first == " " {
            stringify.removeFirst()
        }
        
        if stringify.last == " " {
            stringify.removeLast()
        }
        
        return (stringify, tags)
    }

}
