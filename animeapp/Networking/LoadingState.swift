//
//  LoadingState.swift
//  animeapp
//
//  Created by Vignesh Iyer on 11/23/25.
//

import Foundation

enum LoadingState<T: Equatable>: Equatable {
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
        if case .error(let error) = self { return error }
        return nil
    }
}
