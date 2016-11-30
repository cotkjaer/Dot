//
//  CGPath.swift
//  Dot
//
//  Created by Christian Otkjær on 23/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

// MARK: - <#comment#>

extension CGPath
{
    var uiPath : UIBezierPath { return UIBezierPath(cgPath: self) }
}
