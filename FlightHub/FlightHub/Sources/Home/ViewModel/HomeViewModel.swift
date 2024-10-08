//
//  HomeViewModel.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func setupTitles()
}

final class HomeViewModel {
    let welcomeLabelText = "home.description".localized
    let welcomeButtonTitle = "home.button.title".localized
    
    private weak var delegate: HomeViewModelProtocol?
}

extension HomeViewModel {
    public func delegate(delegate: HomeViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func setupTitles() {
        delegate?.setupTitles()
    }
}
