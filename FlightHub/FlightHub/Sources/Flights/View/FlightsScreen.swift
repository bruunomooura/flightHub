//
//  FlightsScreen.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import UIKit

protocol FlightsScreenProtocol: AnyObject {
    func didTapFilterButton()
}

class FlightsScreen: UIView {
    
    private weak var delegate: FlightsScreenProtocol?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "flights.searchBar.placeholder".localized
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.barTintColor = .white
        searchBar.keyboardType = .alphabet
        searchBar.autocapitalizationType = .allCharacters
        searchBar.isAccessibilityElement = true
        searchBar.accessibilityTraits = .searchField
        searchBar.accessibilityLabel = "flights.searchBar.placeholder".localized
        searchBar.accessibilityHint = "flights.searchBar.accessibilityHint".localized
        
        // Configure the placeholder color
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.background.withAlphaComponent(0.7)
        ]
        let attributedPlaceholder = NSAttributedString(string: searchBar.placeholder ?? "", attributes: placeholderAttributes)
        searchBar.searchTextField.attributedPlaceholder = attributedPlaceholder
        
        // Configure the color of the typed text
        searchBar.searchTextField.defaultTextAttributes = [
            .foregroundColor: UIColor.background,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        // Configure the color of the magnifying glass image and the search bar clear button
        if let textField = searchBar.value(forKey: "searchField") as? UITextField,
           let leftView = textField.leftView as? UIImageView,
           let clearButton = textField.value(forKey: "clearButton") as? UIButton {
            
            // Configure the color of the searchBar magnifying glass
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = .background.withAlphaComponent(0.7)
            
            // Configure the color of the clear button
            clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.tintColor = .background.withAlphaComponent(0.7)
        }
        return searchBar
    }()
    
    private lazy var filterButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 25,
            weight: .regular,
            scale: .default)
        let image = UIImage(
            systemName: "line.horizontal.3.decrease.circle")?
            .withConfiguration(configuration)
        
        button.setImage(image, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isAccessibilityElement = true
        button.backgroundColor = .white
        button.accessibilityTraits = .button
        button.accessibilityLabel = "flights.filterButton.accessibilityLabel".localized
        button.accessibilityHint = "flights.filterButton.accessibilityHint".localized
        
        button.addTarget(self, action: #selector(tappedFilterButton), for: .touchDown)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0,
                                                                     leading: 16,
                                                                     bottom: 16,
                                                                     trailing: 16)
        stackView.backgroundColor = .background
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.separatorColor = .background
        tableView.register(FlightTableViewCell.self, forCellReuseIdentifier: FlightTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var noResultsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "flights.title.noResults".localized
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .background
        label.isHidden = true
        return label
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
}

extension FlightsScreen {
    // MARK: - Functions
    
    // MARK: Set Delegate
    /**
     Sets the delegate that handles the filter button tap event.
     
     - Parameter delegate: The object conforming to `FlightsScreenProtocol`.
     */
    public func delegate(delegate: FlightsScreenProtocol?) {
        self.delegate = delegate
    }
    
    // MARK: Filter Button Action
    /**
     Handles the filter button tap event and notifies the delegate.
     */
    @objc
    private func tappedFilterButton(_ sender: UIButton) {
        sender.animateTap()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            self.delegate?.didTapFilterButton()
        }
    }
    
    // MARK: Setup Table View
    /**
     Configures the table view with a data source and delegate.
     
     - Parameter dataSourceAndDelegate: The data source and delegate for the table view.
     */
    public func setupTableView(_ dataSourceAndDelegate: FlightsTableViewDataSource) {
        tableView.delegate = dataSourceAndDelegate
        tableView.dataSource = dataSourceAndDelegate
    }
    
    // MARK: Setup Search Bar
    /**
     Configures the search bar with a delegate.
     
     - Parameter delegate: The search bar delegate.
     */
    public func setupSearchBar(delegate: UISearchBarDelegate) {
        searchBar.delegate = delegate
    }
    
    // MARK: Reload Table View
    /**
     Reloads the table view data.
     */
    public func reloadTableView() {
        tableView.reloadData()
    }
    
    // MARK: No Results
    /**
     Displays or hides the no results label and table view based on whether there are flight results.
     
     - Parameter noResults: A boolean indicating if there are no results.
     */
    public func noResults(noResults: Bool) {
        tableView.isHidden = noResults
        noResultsLabel.isHidden = !noResults
    }
    
    // MARK: Hide Keyboard
    /**
     Dismisses the keyboard by resigning the search bar's first responder status.
     */
    public func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
}

extension FlightsScreen: ViewCode {
    // MARK: Add Subviews
    /**
     Adds the subviews to the main view.
     */
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(filterButton)
        addSubview(tableView)
        addSubview(noResultsLabel)
    }
    
    // MARK: Setup Constraints
    /**
     Configures the layout constraints for the subviews.
     */
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filterButton.heightAnchor.constraint(equalToConstant: 50),
            filterButton.widthAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            noResultsLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            noResultsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            noResultsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            noResultsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
        ])
    }
    
    // MARK: Extra Configuration
    /**
     Additional configurations for the view.
     */
    func setupStyle() {
        backgroundColor = .white
        filterButton.tintColor = .background
    }
}

#Preview {
    UINavigationController(rootViewController: FlightsVC(viewModel: FlightsViewModel(flightsService: AppConfig.flightsService(), flightsManager: FlightsManager())))
}
