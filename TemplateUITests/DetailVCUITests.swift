//
//  DetailVCUITests.swift
//  TemplateUITests
//
//  Created by Apple on 08/03/22.
//

import XCTest
@testable import Template

class DetailVCUITests: XCTestCase {

    func testDetailViewPlayingVideo() {
        let app = XCUIApplication()
        
        app.launch()
        
        let songsTableViewTable = app.tables["songsTableView"]
        
        app.searchFields.firstMatch.tap()
        
        app.searchFields.firstMatch.typeText("H")
        songsTableViewTable.cells.firstMatch.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Play/Pause"]/*[[".otherElements[\"playView\"]",".otherElements[\"videoPlayer\"]",".buttons[\"Play\"]",".buttons[\"Play\/Pause\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(10)
        app/*@START_MENU_TOKEN@*/.buttons["Play/Pause"]/*[[".otherElements[\"playView\"]",".otherElements[\"videoPlayer\"]",".buttons[\"Play\"]",".buttons[\"Play\/Pause\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()                                                    
    }

}
