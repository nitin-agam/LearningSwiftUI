//
//  LoadingState.swift
//  Ghibli
//
//  Created by Nitin Kumar on 15/11/25.
//

import Foundation

enum LoadingState<T> {
    
    case idle
    case loading
    case loaded(T)
    case error(String)
    
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var data: T? {
        if case .loaded(let data) = self { return data }
        return nil
    }
    
    var error: String? {
        if case .error(let message) = self { return message }
        return nil
    }
}
