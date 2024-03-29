//
//  GetForecastTests.swift
//  WeatherAppTests
//
//  Created by Douglas Moreira on 19/09/23.
//

import XCTest
@testable import WeatherApp

final class GetForecastTests: XCTestCase {
    private let forecastRepositorySpy = ForecastRepositoryProtocolSpy()
    
    private lazy var sut = GetForecast(repository: forecastRepositorySpy)
    
    func test_getForecast_whenRequestFailure_shouldCompletionWithCorrectErrorType() {
        let expectedError: ForecastError = .error
        
        forecastRepositorySpy.getForecastCompletionToBeReturned = .failure(expectedError)
        
        sut.getForecast { result in
            switch result {
            case .success:
                XCTFail("Got success instead failure")
            case .failure(let failure):
                XCTAssertEqual(failure, expectedError)
            }
        }
        
        XCTAssertEqual(forecastRepositorySpy.getForecastCallCount, 1)
    }
    
    func test_getForecast_whenRequestSucced_shouldCompletionWithCorrectValue() {
        let expectedCurrentWeather: CurrentWeather = .init(temperature: 0)
        
        forecastRepositorySpy.getForecastCompletionToBeReturned = .success(expectedCurrentWeather)
        
        sut.getForecast { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success?.temperature, expectedCurrentWeather.temperature)
            case .failure(let failure):
                XCTAssertNil(failure)
            }
        }
        
        XCTAssertEqual(forecastRepositorySpy.getForecastCallCount, 1)
    }
}
