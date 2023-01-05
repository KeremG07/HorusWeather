//
//  SearchBarDelegate.swift
//  Horus
//
//  Created by apple on 3.01.2023.
//

import Foundation
import UIKit

protocol SearchBarDelegate:UISearchBarDelegate,UISearchDisplayDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) 

        
    
    
}
