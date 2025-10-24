//
//  SwiftDataBucketTravelTests.swift
//  SwiftDataBucketTravelTests
//
//  Created by Rogelio Villarreal on 10/23/25.
//

import Testing
@testable import SwiftDataBucketTravel

struct SwiftDataBucketTravelTests {

    @Test("Name must not be empty or whitespace")
    func testNameValidation() async throws {

        #expect(Task.isValidName("Cupertino"))
        #expect(Task.isValidName("San Francisco"))
        #expect(Task.isValidName("A"))
        
        #expect(!Task.isValidName(""))
        #expect(!Task.isValidName("   "))
        #expect(!Task.isValidName("\t\n"))
    }

}
