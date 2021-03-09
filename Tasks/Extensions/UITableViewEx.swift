//
//  UITableViewEx.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 27.02.2021.
//

import UIKit

extension UITableView {
    func indexPath(for view: UIView) -> IndexPath? {
        let location = view.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: location)
    }
}
