//
//  StoreState.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 13/2/2025.
//

import Foundation

enum LoadingState<DataType> {
    case loading(DataType? = nil)
    case loaded(DataType)
    case error(Error)
}

extension LoadingState {
    var currentValue: DataType? {
        switch self {
        case .loading(let value): return value
        case .loaded(let value): return value
        case .error: return nil
        }
    }

    var index: Int {
        switch self {
        case .loading: return 0
        case .loaded: return 1
        case .error: return 2
        }
    }
}
