//
//  HomeVC.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import UIKit

class HomeVC: UIViewController {

    var viewModel: HomeViewModel = HomeViewModel()
    var screen: HomeScreen?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate(delegate: self)
        viewModel.delegate(delegate: self)
        viewModel.setupTitles()
    }
    
    override func loadView() {
        self.screen = HomeScreen()
        view = screen
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
}

extension HomeVC: HomeScreenProtocol {
    func didTapWelcomeButton() {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

extension HomeVC: HomeViewModelProtocol {
    func setupTitles() {
        screen?.setupTitles(viewModel.welcomeLabelText, viewModel.welcomeButtonTitle)
    }
}

#Preview {
    UINavigationController(rootViewController: HomeVC())
}
