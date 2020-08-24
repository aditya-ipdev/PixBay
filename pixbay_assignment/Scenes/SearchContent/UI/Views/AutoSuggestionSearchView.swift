//
//  AutoSuggestionSearchView.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 23/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import UIKit

protocol AutoSuggestionCellDelegate {
    func cellDidTapped(str: String)
}

class AutoSuggestionSearchView: XibContainerView {

    //MARK: - IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - PROPERTIES
    var localDataBase: LocalDatabase?
    var delegate: AutoSuggestionCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(localDataBase: LocalDatabase) {
        self.localDataBase = localDataBase 
    }
    
    
}




//MARK: - EXTENSIONS
extension AutoSuggestionSearchView: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalDatabase.LocalDBRef.dbList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = LocalDatabase.LocalDBRef.dbList[indexPath.row].searchedKeyword
        cell?.selectionStyle = .none
        cell?.textLabel?.font = cell?.textLabel?.font.withSize(15)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.cellDidTapped(str: LocalDatabase.LocalDBRef.dbList[indexPath.row].searchedKeyword ?? "")
    }
    
}
