//
//  CharacterDetailView.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDetailView: UIViewController {

    var presenter: CharacterDetailPresenterProtocol!

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var characterComicsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewReady()
    }
}

extension CharacterDetailView: CharacterDetailViewProtocol {
    
    func display(image: String) {
        guard let url = URL(string: image) else { return }
        characterImageView?.kf.setImage(with: url)
    }
    
    func display(name: String) {
        characterNameLabel.text = name
    }
    
    func display(description: String) {
        characterDescriptionLabel.text = description
    }
    
    func display(comics: String) {
        characterComicsLabel.text = comics
    }
}
