//
//  AppStoreReview.swift
//  TestFirebase
//
//  Created by Teakyung Yang on 2020/03/30.
//  Copyright © 2020 Teakyung Yang. All rights reserved.
//

import Foundation
import StoreKit

//
// 앱스토어에 있을 동안에만..을 체크 할 수 있나?
// 새 버전을 첫 실행 후 이튿날 한번, 1년에 최대 3번은 애플의 권고사항
//
enum AppStoreReview {
  static let maxRequestReviewCount = 3
  static let minDelayDay = 1
  
  @UserDefault("isReviewed", defaultValue: false)
  static var isReviewed: Bool

  @UserDefault("firstLaunchTime", defaultValue: Date())
  static var firstLaunchDate: Date
  
  @UserDefault("requestReviewCount", defaultValue: 0)
  static var requestReviewCount: Int

  @UserDefault("lastRequestVersion", defaultValue: "0.0.0")
  static var lastRequestVersion: String

  
  static func checkRequest() {
    // reset if were new version
    if isReviewed {
      if lastRequestVersion != Bundle.main.appVersion && requestReviewCount < maxRequestReviewCount {
        isReviewed = false
      }
    }
    
    if isReviewed == false {
      // asking after a day of installed day
      let diff = firstLaunchDate.diffDay(to: Date())
      
      if diff >= minDelayDay {
        requestAppReview()
        isReviewed = true
      }
    }
  }
  
  static func requestAppReview() {
    let requestCount = AppStoreReview.requestReviewCount + 1

    if requestCount >= maxRequestReviewCount {
      print("no more request! requestReviewCount:\(requestCount) ")
      return
    }

    // only asking for new version
    let currentVersion = Bundle.main.appVersion
    
    if AppStoreReview.lastRequestVersion == currentVersion {
      print("already requested version! lastVersion:\(lastRequestVersion) ")
      return
    }

    print("review request count:\(requestCount) currentVersion:\(currentVersion)")

    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
      SKStoreReviewController.requestReview()
      AppStoreReview.requestReviewCount = requestCount
      AppStoreReview.lastRequestVersion = currentVersion
    }
  }
}

extension AppStoreReview {
  #if DEBUG
  static func initDebugSetting() {
    isReviewed = false
    requestReviewCount = 0
    lastRequestVersion = "0.0.0"
  }
  #endif
}
