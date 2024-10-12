//
//  HomeScreen.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import UIKit

protocol HomeScreenProtocol: AnyObject {
    func didTapWelcomeButton()
}

class HomeScreen: UIView {

    private weak var delegate: HomeScreenProtocol?
    
    public func delegate(delegate: HomeScreenProtocol?) {
        self.delegate = delegate
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.logoFlightHub
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.isAccessibilityElement = true
        label.accessibilityTraits = .none
        return label
    }()

    private lazy var welcomeButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.background, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 34
        button.isAccessibilityElement = true
        button.backgroundColor = .white
        button.accessibilityTraits = .button
        button.addTarget(self, action: #selector(tappedWelcomeButton), for: .touchDown)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 60
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
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
    
    public func setupTitles(_ welcomeLabelText: String, _ welcomeButtonTitle: String) {
        welcomeLabel.text = welcomeLabelText
        welcomeLabel.accessibilityLabel = welcomeLabelText
        
        welcomeButton.setTitle(welcomeButtonTitle, for: .normal)
        welcomeButton.accessibilityLabel = welcomeButtonTitle
    }
    
    @objc
    private func tappedWelcomeButton(_ sender: UIButton) {
        sender.animateTap()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            self.delegate?.didTapWelcomeButton()
        }
    }
}

extension HomeScreen: ViewCode {
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(welcomeLabel)
        stackView.addArrangedSubview(welcomeButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            logoImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 40),
            logoImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -40),
            
            welcomeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            welcomeLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            welcomeButton.heightAnchor.constraint(equalToConstant: 68),
            welcomeButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 60),
            welcomeButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -60),
        ])
    }
    
    func setupStyle() {
        backgroundColor = UIColor.background
    }
}

#Preview {
    UINavigationController(rootViewController: HomeVC())
}
