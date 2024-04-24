//
//  RecipleaseAlamofireServiceTestCase.swift
//  RecipleaseServiceTestsCase
//
//  Created by Florian Peyrony on 15/11/2021.
//

import XCTest
import Alamofire
@testable import Reciplease

final class RecipleaseAlamofireServiceTestCase: XCTestCase {
    
    var alamofireService: API?
    var expectation: XCTestExpectation!
    
    
    override func setUp() {
     
        let configuration: URLSessionConfiguration = {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = [MockURLProtocol.self]
            return configuration
        }()
        let session = Session(configuration: configuration)
        alamofireService = API(manager: session)
    }
  
    func testGetRecipeShouldPostFailedCallBackIfNoData() {
       
        MockURLProtocol.requestHandler = { (request) throws ->  (HTTPURLResponse, Data?) in
            return (FakeResponseData.responseOK!, Data())
        }
        let expectetion = XCTestExpectation(description: "Wait for queue change")
        alamofireService?.fetchAPIData(ingredient: "tomatoes", callback: { (success, recipe) in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectetion.fulfill()
        })
    
        wait(for: [expectetion], timeout: 5)
   
    }
    func testGetRecipeShouldPostFailCallbackIfError() {
        // Given
        MockURLProtocol.requestHandler = { (request) throws ->  (HTTPURLResponse, Data?) in
            throw NSError(domain: "", code: -1, userInfo: nil)
        }
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        alamofireService?.fetchAPIData(ingredient: "tomatoes", callback: { (success, recipe) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testGetRecipeShouldPostFailCallbackIfIncorrectResponse() {
        // Given
        MockURLProtocol.requestHandler = { (request) throws ->  (HTTPURLResponse, Data?) in
            return (FakeResponseData.responseKO!, Data())
        }
        // When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        alamofireService?.fetchAPIData(ingredient: "tomatoes", callback: { (failure, recipe) in
            // then
            XCTAssertFalse(failure)
            XCTAssertNil(recipe)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 6)
    }
    func testGetRecipeShouldPostFailCallbackIfIncorrectData() {
        // Given
        MockURLProtocol.requestHandler = { (request) throws ->  (HTTPURLResponse, Data?) in
            return (FakeResponseData.responseOK!, Data(FakeResponseData.recipeIncorrectData))
        }
        // When
        alamofireService?.fetchAPIData(ingredient: "tomatoes", callback: { (success, recipe) in
            // then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
        })
    }
    func testGetRecipeShouldPostSuccessCallbackIfCorrectData() {
        // Given
        MockURLProtocol.requestHandler = { (request) throws ->  (HTTPURLResponse, Data?) in
            return (FakeResponseData.responseOK!, Data(FakeResponseData.recipeCorrectData))
        }
        // When
        alamofireService?.fetchAPIData(ingredient: "tomatoes", callback: { (success, recipe) in
            // then
            let text = "Chicken rice tomatoe"
            XCTAssertTrue(success)
            XCTAssertNotNil(recipe)
            print(recipe!)
            XCTAssertEqual(recipe?.q, text)
            
        })
    }

}


