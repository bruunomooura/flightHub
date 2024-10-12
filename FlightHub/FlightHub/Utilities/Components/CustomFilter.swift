//
//  CustomFilter.swift
//  FlightHub
//
//  Created by Bruno Moura on 10/10/24.
//

import SwiftUI

/**
 A reusable filter view for presenting a list of options and allowing the user to select one.
 
 `CustomFilter` can display any type of data that conforms to the `FilterableProtocol`. It provides a user interface to select a filter option and confirm or cancel the selection.
 
 - Parameters:
   - options: An array of `T` objects (where `T` conforms to `FilterableProtocol`), representing the filter options to display.
   - selected: The currently selected filter option (optional).
   - onConfirm: A closure to execute when the user confirms their selection. It returns the selected option or `nil` if no option is selected.
   - onCancel: A closure to execute when the user cancels the filter selection.
 */
struct CustomFilter<T: FilterableProtocol>: View {
    var options: [T]
    @State var selected: T?
    @Namespace private var animation
    let animationID = "selectedFilter"
    
    /// A closure that is triggered when the user confirms their selection.
    var onConfirm: (T?) -> Void
    
    /// A closure that is triggered when the user cancels the filter selection.
    var onCancel: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            toolbar
            
            filterOptions
            
            Spacer()
            
            bottomButtons
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

extension CustomFilter {
    // MARK: Toobar
    private var toolbar: some View {
        HStack(alignment: .center, spacing: .zero) {
            Spacer()
            Text("customFilter.label.title".localized)
                .font(.system(size: 22))
                .fontWeight(.regular)
                .foregroundStyle(.black)
                .accessibilityAddTraits(.isHeader)
                .accessibilityLabel("customFilter.label.title.accessibilityLabel".localized)
                .accessibilityHint("customFilter.label.title..accessibilityHint".localized)
            
            Spacer()
            
            Button {
                withAnimation {
                    selected = nil
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        onConfirm(selected)
                    }
                }
            } label: {
                Image(systemName: SystemImage.eraserFill.rawValue)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.black)
            }
            .accessibilityLabel("customFilter.button.eraser.accessibilityLabel".localized)
            .accessibilityHint("customFilter.button.eraser.accessibilityHint".localized)
        }
    }
    
    private var filterOptions: some View {
        VStack(alignment: .center, spacing: 10) {
            ForEach(options, id: \.id) { option in
                Button {
                    withAnimation {
                        selected = option
                    }
                } label: {
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: option.icon)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.black)
                            .padding(.leading, 10)
                            .accessibilityHidden(true)
                        
                        Text(option.title.capitalized)
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        if selected == option {
                            Image(systemName: SystemImage.puncturedCircle.rawValue)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.white, Color.background)
                                .matchedGeometryEffect(id: animationID, in: animation)
                                .accessibilityHidden(true)
                        } else {
                            Image(systemName: SystemImage.circleFill.rawValue)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.background.opacity(0.2))
                                .accessibilityHidden(true)
                        }
                    }
                    .frame(height: 40)
                    .accessibilityElement(children: .combine)
                    .accessibilityValue("\(option.description)")
                    .accessibilityHint(selected == option
                                       ? "customFilter.filterOptions.selected.accessibilityHint".localized
                                       : "customFilter.filterOptions.notSelected.accessibilityHint".localized)
                }
                .id(option)
            }
            .accessibilityLabel("customFilter.filterOptions.accessibilityLabel".localized)
        }
    }
    
    private var bottomButtons: some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    onCancel()
                }
            } label: {
                Text("customFilter.button.cancel".localized)
                    .foregroundStyle(.black)
            }
            .buttonStyle(.stroke())
            .accessibilityLabel("customFilter.button.cancel.accessibilityLabel".localized)
            .accessibilityHint("customFilter.button.cancel.accessibilityHint".localized)
            
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    onConfirm(selected)
                }
            } label: {
                Text("customFilter.button.filter".localized)
                    .foregroundStyle(.white)
            }
            .buttonStyle(.custom())
            .accessibilityLabel("customFilter.button.filter.accessibilityLabel".localized)
            .accessibilityHint("customFilter.button.filter.accessibilityHint".localized)
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    CustomFilter(options: FlightStatus.allCases,
                 onConfirm: { selectedItem in
        if let selectedItem = selectedItem {
            print("Item selecionado: \(String(describing: selectedItem))")
        }},
                 onCancel: { print("Filtro cancelado") })
}
