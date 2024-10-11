//
//  FlightsTableViewDataSource.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import Foundation
import UIKit

final class FlightsTableViewDataSource: NSObject, UITableViewDataSource {
    private var content: [Flight] = []
    var didScrollHideKeyboard: (() -> Void)?
    
    // MARK: Reload table view
    /**
     Reloads the table view with the given list of flights.
     
     - Parameter content: The array of flights to be displayed in the table view.
     */
    func reloadTableView(with content: [Flight]) {
        self.content = content
    }
    
    // MARK: Number of rows in section
    /**
     Returns the number of rows in the given section of the table view.
     - Returns: The number of rows in the section.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        content.count
    }
    
    // MARK: Configure cell
    /**
     Configures and returns the cell for the given index path.
     - Returns: A configured `UITableViewCell` displaying flight data.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightTableViewCell.identifier, for: indexPath) as? FlightTableViewCell else { return UITableViewCell() }
        let flight = content[indexPath.row]
        cell.isUserInteractionEnabled = false
        cell.configureCell(flight: flight)
        return cell
    }
}

extension FlightsTableViewDataSource: UITableViewDelegate {
    // MARK: Row height
    /**
     Returns the height for rows in the table view.
     - Returns: The height of the row as a `CGFloat` value.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    // MARK: Hide keyboard on scroll
    /**
     Notifies when the table view begins dragging to hide the keyboard.
     */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        didScrollHideKeyboard?()
    }
}
