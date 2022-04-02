//
//  CustomSpinnerSimple.swift
//  CustomSpinnerApp
//
//  Created by Alexander Germek on 29.03.2022.
//

import UIKit

final class CustomSpinnerSimple: UIView {
	// MARK: - Properties
	/// Объявляем нежные нам переменные для CAReplicatorLayer
	private lazy var replicatorLayer: CAReplicatorLayer = {
		let caLayer = CAReplicatorLayer()
		return caLayer
	}()

	/// и CAShapeLayer:
	private lazy var shapeLayer: CAShapeLayer = {
		let shapeLayer = CAShapeLayer()
		return shapeLayer
	}()

	/// Переменная для названия анимации (используем ниже)
	private let keyAnimation = "opacityAnimation"

	// MARK: - Init
	/// Удобный инициализатор
	/// - Parameter squareLength: длина стороны квадрата(вью)
	/// в котором будет спиннер
	/// По умполчанию спиннер устанавливается в центр экрана
	convenience init(squareLength: CGFloat) {
		let mainBounds = UIScreen.main.bounds
		let rect = CGRect(origin: CGPoint(x: (mainBounds.width-squareLength)/2,
										  y: (mainBounds.height-squareLength)/2),
						  size: CGSize(width: squareLength, height: squareLength))
		self.init(frame: rect)
	}

	/// Инициализатор через frame, который позволяет установить спиннер
	/// в любое место экрана
	/// - Parameter frame: фрейм в котором будет спиннер
	override init(frame: CGRect) {
		super.init(frame: frame)
		// добавляем replicatorLayer на слой нашего класса:
		layer.addSublayer(replicatorLayer)
		// добавляем shapeLayer на replicatorLayer:
		replicatorLayer.addSublayer(shapeLayer)
	}

	/// Обязательный нициализатор,
	/// available(*, unavailable) - означает что он не будет отображаться
	///в подсказке при создании класса
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		// С помощью UIBezierPath рисуем круг и отображаем
		/// на нашем shapeLayer
		let size = min(bounds.width/2, bounds.height/2)
		let rect = CGRect(x: size/4, y: size/4, width: size/4, height: size/4)
		let path = UIBezierPath(ovalIn: rect)
		shapeLayer.path = path.cgPath

		// Устанавливаем размеры для replicatorLayer
		replicatorLayer.frame = bounds
		replicatorLayer.position = CGPoint(x: size, y:  size)
	}

	// MARK: - Animation's public functions

	/// Функция для запуска анимации
	/// - Parameters:
	///   - delay: Время анимации, чем меньше значение,
	/// тем быстрее будет анимация
	///   - replicates: количество реплик, то есть экземляров класса replicatorLayer
	func startAnimation(delay: TimeInterval, replicates: Int) {
		replicatorLayer.instanceCount = replicates
		replicatorLayer.instanceDelay = delay
		// Определяем преобразование для реплики - следующая реплика будет
		// повернута на угол angle, относительно предыдущей
		let angle = CGFloat(2.0 * Double.pi) / CGFloat(replicates)
		replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)

		// А далее сама анимация для нашего shapeLayer:
		shapeLayer.opacity = 0 // начальное значение прозрачности
		// анимация прозрачности:
		let opacityAnimation = CABasicAnimation(keyPath: "opacity")
		// от какого значения (1 - непрозрачно, 0 полностью прозрачно)
		opacityAnimation.fromValue = 0.1
		opacityAnimation.toValue = 0.9 // до какого значения

		// продолжительность:
		opacityAnimation.duration = Double(replicates) * delay
		// повторять бесконечно:
		opacityAnimation.repeatCount = Float.infinity
		// добавляем анимацию к слою по ключу keyAnimation:
		shapeLayer.add(opacityAnimation, forKey: keyAnimation)
	}

	/// Функция остановки анимации - удаляем ее по ключу keyAnimation с нашего слоя
	func stopAnimation() {
		guard shapeLayer.animation(forKey: keyAnimation) != nil else {
			return
		}
		shapeLayer.removeAnimation(forKey: keyAnimation)
	}

	// MARK: - Deinit
	/// Останавливаем анимацию при деините экземпляра
	deinit {
		stopAnimation()
	}
}
