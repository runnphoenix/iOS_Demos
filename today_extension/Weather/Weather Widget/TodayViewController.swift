//
//  TodayViewController.swift
//  Weather Widget
//
//  Created by workMac on 15/6/1.
//  Copyright (c) 2015年 Appcoda. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherDataKit

class TodayViewController: WeatherDataViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
}
