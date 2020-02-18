//
//  CharacterListCell.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import UIKit
import Kingfisher

protocol CharacterListCellProtocol {
    func display(image: String)
    func display(name: String)
}

class CharacterListCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension CharacterListCell: CharacterListCellProtocol {
    
    func display(image: String) {
        guard let url = URL(string: image) else { return }
        characterImageView?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { [weak self] _ in
            self?.setNeedsLayout()
        })
    }
    
    func display(name: String) {
        characterNameLabel?.text = name
    }
}
