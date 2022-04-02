//
//  ViewController.swift
//  CustomSpinnerApp
//
//  Created by Alexander Germek on 27.03.2022.
//

import UIKit

class ViewController: UIViewController {

	private var spinnerCollectionView: UICollectionView!

	private lazy var defaultSize: CGFloat = 100

	private lazy var spinners: [CustomSpinnerViewModel] = [
		.init(type: .circle, size: defaultSize),
		.init(type: .circle2, size: defaultSize),

			.init(type: .square, size: defaultSize),
		.init(type: .square2, size: defaultSize),
		.init(type: .square3, size: defaultSize),

		.init(type: .triangleOut3, size: defaultSize),

			.init(type: .triangle, size: defaultSize),
		.init(type: .triangle2, size: defaultSize),
		.init(type: .triangle3, size: defaultSize),


			.init(type: .triangleOut, size: defaultSize),
		.init(type: .triangleOut2, size: defaultSize),
		.init(type: .triangleOut4, size: defaultSize),

			.init(type: .doubleTriangle, size: defaultSize),
		.init(type: .triangleOut5, size: defaultSize),
		.init(type: .dtTT, size: defaultSize),
		.init(type: .triangleSharp, size: defaultSize)
	]

	override func viewDidLoad() {
		super.viewDidLoad()
		configureCollectionView()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureCollectionView()
	}

	func configureCollectionView() {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 1
		layout.minimumInteritemSpacing = 1
		layout.itemSize = CGSize(width: (view.frame.width / 4) - 3, height: (view.frame.height / 4) - 3)

		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.delegate = self
		cv.dataSource = self

		cv.backgroundColor = .systemBackground

		cv.register(CustomSpinnerCollectionViewCell.self, forCellWithReuseIdentifier: CustomSpinnerCollectionViewCell.identifier)
		spinnerCollectionView = cv
		view.addSubview(spinnerCollectionView)
		spinnerCollectionView.frame = view.bounds
	}
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return spinners.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CustomSpinnerCollectionViewCell.identifier,
			for: indexPath) as? CustomSpinnerCollectionViewCell else {
				return UICollectionViewCell()
			}

		cell.configure(viewModel: spinners[indexPath.row])

		return cell
	}
}
