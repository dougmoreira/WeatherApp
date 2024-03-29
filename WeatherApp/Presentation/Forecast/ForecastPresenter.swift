//
//  ForecastPresenter.swift
//  WeatherApp
//
//  Created by Douglas Moreira on 18/09/23.
//

import Foundation

public protocol ForecastPresentationLogic {
    func presentForecast(with temperature: Double)
    func presentForecastError()
}

final class ForecastPresenter: ForecastPresentationLogic {
    weak var viewController: ForecastDisplayLogic?
    
    func presentForecast(with temperature: Double) {
        guard let viewController = viewController else { return }
        
        viewController.displayForecast(with: temperature)
    }
    
    func presentForecastError() {
        guard let viewController = viewController else { return }
        
        viewController.displayForecastError()
    }
    
}
