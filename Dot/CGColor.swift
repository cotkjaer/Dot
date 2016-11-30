//
//  CGColor.swift
//  Dot
//
//  Created by Christian Otkjær on 23/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import Foundation

// MARK: - UIColor

extension CGColor
{
    public var uiColor: UIColor { return UIColor(cgColor: self) }
}

