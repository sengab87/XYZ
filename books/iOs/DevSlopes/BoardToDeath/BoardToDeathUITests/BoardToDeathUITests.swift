//
//  BoardToDeathUITests.swift
//  BoardToDeathUITests
//
//  Created by Ahmed Sengab on 1/24/19.
//  Copyright © 2019 Caleb Stultz. All rights reserved.
//

import XCTest
@testable import BoardToDeath
class BoardToDeathUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
    func testTemp(){
        
    }
    func testOnBoarding_WhenSwipped_NextVCLoads()
    {
        XCTAssertTrue(app.staticTexts["Welcome to BoardToDeath"].exists)
        app.swipeLeft()
        XCTAssertTrue(app.staticTexts["Custom Puppy Content"].exists)
    }
    /*func testOnBoarding_WhenDoneButtonTapped_PresentAlert(){
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()
        XCTAssertTrue(app.alerts["Alert"].exists)
        
    }*/
    
    func testOnBoarding_WhenFinished_OnBoardVCDismess(){
        XCTAssertTrue(app.isDisplayingOnBoarding)
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()
        XCTAssertFalse(app.isDisplayingOnBoarding)
    }
    func testInterfaceVC_AlertViewShows_WhenOnboardingComplete(){
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()
        
        XCTAssertTrue(app.isDisplayingAlertVC,"Alert VC should show with OnBoarding Dismisses")
    }
    func testEmailInput_WhenGivenEmail_FillTextField(){
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("Caleb@devslopes.com")
        XCTAssertTrue(app.textFields["Caleb@devslopes.com"].exists)
    }
    func testPasswordInput_WhenGivenPassword_FillTextField(){
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()
        
        let emailTextField = app.textFields["Password"]
        emailTextField.tap()
        emailTextField.typeText("dick")
        XCTAssertTrue(app.textFields["dick"].exists)
    }
    func testImageDownload_WhenDownloadComplete_CaptionLabelShowing(){
        let imageCaption = app.staticTexts["What a beautiful image!"]
        let exist = NSPredicate(format: "exists == true")
        expectation(for: exist, evaluatedWith: imageCaption, handler: nil)
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()
        app.alerts["You did it!"].buttons["Awesome!"].tap()
        app.buttons["Load Image"].tap()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(imageCaption.exists)
       //app.buttons["loadImage"]
    }
}


extension XCUIApplication{
    var isDisplayingOnBoarding : Bool {
        // view is visible
        return otherElements["onboardingView"].exists
    }
    var isDisplayingAlertVC: Bool {
        return alerts["You did it!"].exists
    }
}
