//
//  UIViewFrameExtension.swift
//  ToDoList
//
//  Created by Vaibhav Indalkar on 20/02/18.
//  Copyright © 2018 Vaibhav Indalkar. All rights reserved.
//

import UIKit

extension UIView {
    
    func X() -> CGFloat {
        return self.frame.origin.x
    }
    
    func Y() -> CGFloat {
        return self.frame.origin.y
    }
    
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    func height() -> CGFloat {
        return self.frame.size.height
    }
}
