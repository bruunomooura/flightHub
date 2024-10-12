//
//  FlightTableViewCell.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: FlightTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private lazy var flightIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        label.isAccessibilityElement = true
        label.accessibilityLabel = "flights.flightIdLabel.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var flightStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isAccessibilityElement = true
        label.accessibilityLabel = "flights.flightStatusLabel.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var flightCompletionStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isAccessibilityElement = true
        label.accessibilityLabel = "flights.flightCompletionStatusLabel.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var flightDepartureDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        label.isAccessibilityElement = true
        label.accessibilityLabel = "flights.flightDepartureDateLabel.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var flightArrivalDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        label.isAccessibilityElement = true
        label.accessibilityLabel = "flights.flightArrivalDateLabel.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var flightDepartureTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .black)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        label.isAccessibilityElement = true
        label.accessibilityLabel = "flights.flightDepartureTimeLabel.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var flightArrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .black)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        label.isAccessibilityElement = true
        label.accessibilityLabel = "flights.flightArrivalTimeLabel.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var flightDepartureImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: SystemImage.airplaneDeparture.rawValue)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var flightArrivalImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: SystemImage.airplaneArrival.rawValue)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var flightDepartureAirportLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .black
        label.isAccessibilityElement = true
        label.accessibilityLabel = "flights.flightDepartureAirportLabel.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var flightArrivalAirportLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .right
        label.numberOfLines = 2
        label.textColor = .black
        label.isAccessibilityElement = true
        label.accessibilityLabel = "flights.flightArrivalAirportLabel.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var flightAirplaneNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        label.isAccessibilityElement = true
        label.accessibilityLabel = "flights.flightAirplaneNameLabel.accessibilityLabel".localized
        label.accessibilityTraits = .none
        return label
    }()
    
    private lazy var flightDepartureTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0, leading: 5, bottom: 0, trailing: 0)
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var flightArrivalTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 0, trailing: 5)
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setAccessibilityElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
}

extension FlightTableViewCell {
    // MARK: - Functions
    
    // MARK: Set Accessibility Elements
    /**
     Configures accessibility elements for the flight information UI.
     
     This function sets the accessibility elements for the flight details labels,
     allowing assistive technologies to navigate through the flight information
     in a defined order.
     */
    private func setAccessibilityElements() {
        self.accessibilityElements = [
            flightIdLabel,
            flightAirplaneNameLabel,
            flightStatusLabel,
            flightCompletionStatusLabel,
            flightDepartureAirportLabel,
            flightDepartureDateLabel,
            flightDepartureTimeLabel,
            flightArrivalAirportLabel,
            flightArrivalDateLabel,
            flightArrivalTimeLabel,
        ]
    }
    
    // MARK: Configure Cell
    /**
     Configures the cell with flight information.
     
     - Parameter flight: The flight object containing the flight data to populate the cell.
     */
    public func configureCell(flight: Flight) {
        flightIdLabel.text = flight.flightID
        flightStatusLabel.text = flight.status.description
        flightStatusLabel.textColor = setColorForFlightStatus(flight.status)
        flightCompletionStatusLabel.text = flight.completionStatus.description
        flightCompletionStatusLabel.textColor = setColorForFlightCompletionStatus(flight.completionStatus)
        flightDepartureDateLabel.text = flight.startDate.formattedDate
        flightArrivalDateLabel.text = flight.endDate.formattedDate
        flightDepartureTimeLabel.text = flight.departureTime
        flightArrivalTimeLabel.text = flight.arrivalTime
        flightDepartureAirportLabel.text = flight.departureAirport
        flightArrivalAirportLabel.text = flight.arrivalAirport
        flightAirplaneNameLabel.text = flight.airplaneName
        
        setAccessibilityValues(flight)
    }
    
    /**
     Returns the color associated with the given flight status.
     
     - Parameter status: The flight status to evaluate.
     - Returns: A UIColor representing the color corresponding to the flight status.
     This function maps flight statuses to specific colors for visual representation in the UI.
     */
    private func setColorForFlightStatus(_ status: FlightStatus) -> UIColor {
        switch status {
        case .upcoming:
            return .orange
        case .canceled:
            return .red
        case .completed:
            return .darkGreen
        case .inFlight:
            return .darkBlue
        }
    }
    
    /**
     Returns the color associated with the given completion status.
     
     - Parameter completionStatus: The completion status to evaluate.
     - Returns: A UIColor representing the color corresponding to the completion status.
     This function maps completion statuses to specific colors for visual representation in the UI.
     */
    private func setColorForFlightCompletionStatus(_ completionStatus: CompletionStatus) -> UIColor {
        switch completionStatus {
        case .delayed:
            return .orange
        case .canceled:
            return .red
        case .onTime:
            return .darkGreen
        }
    }
    
    /**
     Sets accessibility values for the flight information labels.
     
     This function updates the accessibility values for various UI elements
     related to a flight object, enabling better accessibility for users
     relying on assistive technologies.
     
     - Parameter flight: The `Flight` object containing flight details.
     */
    private func setAccessibilityValues(_ flight: Flight) {
        flightIdLabel.accessibilityValue = flight.flightID
        flightStatusLabel.accessibilityValue = flight.status.description
        flightCompletionStatusLabel.accessibilityValue = flight.completionStatus.description
        flightDepartureDateLabel.accessibilityValue = flight.startDate.formattedDate
        flightArrivalDateLabel.accessibilityValue = flight.endDate.formattedDate
        flightDepartureTimeLabel.accessibilityValue = flight.departureTime
        flightArrivalTimeLabel.accessibilityValue = flight.arrivalTime
        flightDepartureAirportLabel.accessibilityValue = flight.departureAirport
        flightArrivalAirportLabel.accessibilityValue = flight.arrivalAirport
        flightAirplaneNameLabel.accessibilityValue = flight.airplaneName
    }
}

extension FlightTableViewCell: ViewCode {
    // MARK: Add Subviews
    /**
     Adds the subviews to the cell.
     */
    func addSubviews() {
        addSubview(flightIdLabel)
        addSubview(flightStatusLabel)
        addSubview(flightCompletionStatusLabel)
        addSubview(flightDepartureDateLabel)
        addSubview(flightArrivalDateLabel)
        addSubview(flightDepartureTimeStackView)
        addSubview(flightArrivalTimeStackView)
        flightDepartureTimeStackView.addArrangedSubview(flightDepartureTimeLabel)
        flightDepartureTimeStackView.addArrangedSubview(flightDepartureImageView)
        
        flightArrivalTimeStackView.addArrangedSubview(flightArrivalImageView)
        flightArrivalTimeStackView.addArrangedSubview(flightArrivalTimeLabel)
        addSubview(flightDepartureAirportLabel)
        addSubview(flightArrivalAirportLabel)
        addSubview(flightAirplaneNameLabel)
    }
    
    // MARK: Setup Constraints
    /**
     Configures the layout constraints for the subviews.
     */
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Components on the left of the screen
            flightIdLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            flightIdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            flightAirplaneNameLabel.topAnchor.constraint(equalTo: flightIdLabel.bottomAnchor),
            flightAirplaneNameLabel.leadingAnchor.constraint(equalTo: flightIdLabel.leadingAnchor),
            
            flightDepartureTimeStackView.topAnchor.constraint(equalTo: flightAirplaneNameLabel.bottomAnchor, constant: 10),
            flightDepartureTimeStackView.leadingAnchor.constraint(equalTo: flightIdLabel.leadingAnchor),
            
            flightDepartureDateLabel.topAnchor.constraint(equalTo: flightDepartureTimeLabel.bottomAnchor),
            flightDepartureDateLabel.centerXAnchor.constraint(equalTo: flightDepartureTimeStackView.centerXAnchor),
            
            flightDepartureAirportLabel.topAnchor.constraint(equalTo: flightDepartureDateLabel.bottomAnchor, constant: 10),
            flightDepartureAirportLabel.leadingAnchor.constraint(equalTo: flightIdLabel.leadingAnchor),
            flightDepartureAirportLabel.widthAnchor.constraint(equalToConstant: 180),
            
            // Components on the right of the screen
            flightStatusLabel.topAnchor.constraint(equalTo: flightIdLabel.topAnchor),
            flightStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            flightCompletionStatusLabel.topAnchor.constraint(equalTo: flightStatusLabel.bottomAnchor),
            flightCompletionStatusLabel.trailingAnchor.constraint(equalTo: flightStatusLabel.trailingAnchor),
            
            flightArrivalTimeStackView.topAnchor.constraint(equalTo: flightAirplaneNameLabel.bottomAnchor, constant: 10),
            flightArrivalTimeStackView.trailingAnchor.constraint(equalTo: flightStatusLabel.trailingAnchor),
            
            flightArrivalDateLabel.topAnchor.constraint(equalTo: flightDepartureTimeLabel.bottomAnchor),
            flightArrivalDateLabel.centerXAnchor.constraint(equalTo: flightArrivalTimeStackView.centerXAnchor),
            
            flightArrivalAirportLabel.topAnchor.constraint(equalTo: flightArrivalDateLabel.bottomAnchor, constant: 10),
            flightArrivalAirportLabel.trailingAnchor.constraint(equalTo: flightStatusLabel.trailingAnchor),
            flightArrivalAirportLabel.widthAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    // MARK: Extra Configuration
    /**
     Additional configurations for the view.
     */
    func setupStyle() {
        backgroundColor = .white
    }
}

#Preview {
    FlightTableViewCell()
}
