//
//  ViewControllerSimple.swift
//  CustomSpinnerApp
//
//  Created by Alexander Germek on 29.03.2022.
//

import UIKit

final class ViewControllerSimple: UIViewController {
	// Спиннер - размер 100
	private lazy var spinner: CustomSpinnerSimple = {
		let spinner = CustomSpinnerSimple(squareLength: 100)
		return spinner
	}()

	// Во viewDidLoad добавляю спиннер  и стартую анимацию
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(spinner)
		spinner.startAnimation(delay: 0.08, replicates: 6)
	}
}
