//
//  FlightsVC.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import UIKit
import SwiftUI

class FlightsVC: UIViewController {
    
    private let viewModel: FlightsViewModel
    var screen: FlightsScreen?
    private var tableViewDataSource: FlightsTableViewDataSource?
    
    init(viewModel: FlightsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupScreen()
        setupViewModel()
        setupSearchBar()
        setupTableView()
        setupDataSourceCallbacks()
    }
    
    override func loadView() {
        self.screen = FlightsScreen()
        view = screen
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
    
    // MARK: - Navigation Bar Setup
    /**
     Configures the navigation bar appearance and title.
     */
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = nil
        appearance.backgroundColor = .background
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        title = "flights.title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // MARK: - Screen delegate
    /**
     Configures the FlightsScreen by setting the delegate.
     */
    private func setupScreen() {
        screen?.delegate(delegate: self)
    }
    
    // MARK: - ViewModel Configuration
    /**
     Configures the ViewModel by setting the delegate and initiating the data loading process.
     */
    private func setupViewModel() {
        viewModel.delegate(delegate: self)
        loadFlightsData()
    }
    
    // MARK: - Data Loading
    /**
     Asynchronously loads flight data.
     */
    private func loadFlightsData() {
        Task {
            await viewModel.loadFlightData()
        }
    }
    
    // MARK: - Search Bar Setup
    /**
     Configures the Search Bar and assigns the delegate.
     */
    private func setupSearchBar() {
        screen?.setupSearchBar(delegate: self)
    }
    
    // MARK: - TableView Setup
    /**
     Initializes and configures the TableView DataSource and connects it to the screen.
     */
    private func setupTableView() {
        tableViewDataSource = FlightsTableViewDataSource()
        guard let dataSource = tableViewDataSource else { return }
        screen?.setupTableView(dataSource)
    }
    
    // MARK: - DataSource Callbacks Setup
    /**
     Defines the DataSource callbacks for handling scroll events and item selection.
     */
    private func setupDataSourceCallbacks() {
        guard let dataSource = tableViewDataSource else { return }
        
        // Callback to hide the keyboard during scroll events
        dataSource.didScrollHideKeyboard = { [weak self] in
            self?.screen?.hideKeyboard()
        }
    }
}

extension FlightsVC {
    // MARK: - Open CustomFilter SwiftUI
    /**
     Opens the custom filter view using SwiftUI.
     */
    private func openFilterSwiftUI() {
        let customFilterView = CustomFilter(
            options: FlightStatus.allCases,
            selected: viewModel.filterApplied,
            onConfirm: { [weak self] selectedFilter in
                self?.viewModel.filterFlightsByStatus(selectedFilter)
                self?.dismissView()
            },
            onCancel: { [weak self] in
                self?.dismissView()
            })
        
        hostingController(customFilterView)
    }
    
    /**
     Dismisses the current view controller.
     */
    private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    /**
     Hosts the custom filter view controller.
     
     - Parameter customFilterView: The SwiftUI view to be hosted.
     */
    private func hostingController(_ customFilterView: CustomFilter<FlightStatus>) {
        let hostingController = UIHostingController(rootView: customFilterView)
        hostingController.view.backgroundColor = .white
        hostingController.modalPresentationStyle = .pageSheet
        
        if let sheet = hostingController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(hostingController, animated: true, completion: nil)
    }
}

extension FlightsVC: UISearchBarDelegate {
    /**
     Called when the text in the search bar changes.
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
    
    /**
     Called when the search button is clicked in the search bar.
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension FlightsVC: FlightsScreenProtocol {
    /**
     Called when the filter button is tapped.
     */
    func didTapFilterButton() {
        screen?.hideKeyboard()
        openFilterSwiftUI()
    }
}

extension FlightsVC: FlightsViewModelProtocol {
    /**
     Updates the table view with the filtered flight results.
     
     - Parameter content: The filtered list of flights.
     */
    func searchText(content: [Flight]) {
        tableViewDataSource?.reloadTableView(with: content)
        screen?.reloadTableView()
        screen?.noResults(noResults: viewModel.noResults)
        screen?.updateCountFlights(content.count)
    }
    
    /**
     Updates the table view with new flight data.
     
     - Parameter content: The updated list of flights.
     */
    func updateData(content: [Flight]) {
        tableViewDataSource?.reloadTableView(with: content)
        screen?.reloadTableView()
        screen?.noResults(noResults: viewModel.noResults)
        screen?.updateCountFlights(content.count)
    }
    
    /**
     Displays an error alert when loading flight data fails.
     
     - Parameters:
     - title: The title of the alert.
     - message: The message providing details about the error.
     */
    func errorLoadFlight(title: String, message: String) {
        let alert = CustomAlert(presenter: self)
        DispatchQueue.main.async {
            alert.alertConfirmation(
                title: title,
                message: message,
                confirmTitle: "useful.tryAgain".localized) {
                    self.loadFlightsData()
                }
        }
    }
    
    /**
     Updates the table view with flights based on the applied filter.
     
     - Parameter content: The filtered list of flights.
     */
    func filterFlights(content: [Flight]) {
        tableViewDataSource?.reloadTableView(with: content)
        screen?.reloadTableView()
        screen?.noResults(noResults: viewModel.noResults)
        screen?.updateCountFlights(content.count)
        screen?.updateIconFilterButton(filter: viewModel.filterApplied)
    }
}

#Preview {
    UINavigationController(rootViewController: FlightsVC(viewModel: FlightsViewModel(flightsService: AppConfig.flightsService(), flightsManager: FlightsManager())))
}
