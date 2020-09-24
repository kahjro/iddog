//
//  DogImageCell.swift
//  iddog
//
//  Created by Arthur Kazuo on 23/09/20.
//

import UIKit
import SDWebImage

class DogImageCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        var view = UIImageView()

        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setupLayout() {
        contentView.addSubview(imageView,constraints: [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }

    func config(url: String?)  {
        setupLayout()
        guard let urlStr = url, let url = URL(string: urlStr) else { return }
        imageView.sd_setImage(with: url, placeholderImage: nil, options: .allowInvalidSSLCertificates, progress: nil, completed: { (image, error, cacheType, url) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            }
        })

    }
}
