//
//  StoreKitLocalDemoTests.swift
//  StoreKitLocalDemoTests
//
//  Created by Gabriel Theodoropoulos.
//

import XCTest
import StoreKitTest
@testable import StoreKitLocalDemo

class StoreKitLocalDemoTests: XCTestCase {

    func testSaladPurchase() throws {
        let session = try SKTestSession(configurationFileNamed: "NonConsumables")
        session.disableDialogs = true
        XCTAssertNoThrow(try session.buyProduct(productIdentifier: "com.appcoda.storekitlocaldemo.salad"))
    }

    
    func testAskToBuy() throws {
        let session = try SKTestSession(configurationFileNamed: "NonConsumables")
        session.clearTransactions()
        session.disableDialogs = true
        session.askToBuyEnabled = true
        
        XCTAssertNoThrow(try session.buyProduct(productIdentifier: "com.appcoda.storekitlocaldemo.salad"))
        
        XCTAssertTrue(session.allTransactions().count == 1)
        XCTAssertTrue(session.allTransactions()[0].state == .deferred)
        
        XCTAssertNoThrow(try session.approveAskToBuyTransaction(identifier: session.allTransactions()[0].identifier))
    }
}
