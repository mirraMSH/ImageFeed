//
//  ImageFeedTests.swift
//  ImageFeedTests
//
//  Created by Мария Шагина on 24.06.2024.
//
@testable import ImageFeed
import XCTest

final class ImageFeedTests: XCTestCase {
   
    func testViewControllerCallsViewDidLoad() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
    }
}
