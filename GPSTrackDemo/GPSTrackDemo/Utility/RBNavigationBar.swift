//
//  RBNavigationBar.swift
//  GPSTrackDemo
//
//  Created by Ruchika Bokadia on 06/01/22.
//

import UIKit

class RBNavigationBar: UINavigationBar {
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit()->Void
    {
        
        self.backgroundColor = UIColor.black
        self.barTintColor = UIColor.black
        
        self.isTranslucent = false
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20.0)]
        self.shadowImage = UIImage()
        self.setBackgroundImage(UIImage(), for: .default)
//        self.addRoundShadow()
       
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()//configureWithTransparentBackground()
            appearance.backgroundColor = UIColor.black
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20.0)]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor.black
            UITabBar.appearance().standardAppearance = tabBarAppearance

//            if #available(iOS 15.0, *) {
//                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
