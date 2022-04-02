//
//  CustomSpinnerCollectionViewCell.swift
//  CustomSpinnerApp
//
//  Created by Alexander Germek on 28.03.2022.
//

import UIKit

class CustomSpinnerCollectionViewCell: UICollectionViewCell {
	static let identifier = "CustomSpinnerCollectionViewCell"

	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 3
		label.font = .systemFont(ofSize: 14, weight: .semibold)
		return label
	}()

	private var spinner: CustomSpinner!

	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(descriptionLabel)
		descriptionLabel.frame = CGRect(origin: .zero,
										size: CGSize(width: contentView.bounds.width,
													 height: contentView.bounds.height/3))
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(viewModel: CustomSpinnerViewModel) {
		let type = viewModel.type
		let spinnerSize = viewModel.size
		let delay = [0.02, 0.04,  0.06, 0.08, 0.1].shuffled().first!
		let count = Int.random(in: 10...30)

		switch (type, spinnerSize) {
		case (.some(let spinnerType), .some(let size)):
			spinner = CustomSpinner(squareLength: size, type: spinnerType, superView: contentView)

		case (.some(let spinnerType), .none):
			spinner = CustomSpinner(type: spinnerType, superView: contentView)

		case (.none, .some(let size)):
			spinner = CustomSpinner(squareLength: size,superView: contentView)

		default:
			spinner = CustomSpinner(squareLength: 100, superView: contentView)
			descriptionLabel.text = "size = 100, type = .circle"
		}

		contentView.addSubview(spinner)
		descriptionLabel.text = "delay = \(delay),\nreplicates = \(count),\ntype = \(type ?? .circle)"
		spinner.startAnimation(delay: delay, replicates: count)
	}
}
