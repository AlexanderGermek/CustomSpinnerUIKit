//
//  CustomSpinner.swift
//  CustomSpinnerApp
//
//  Created by Alexander Germek on 27.03.2022.
//

import UIKit

enum SpinnerType {
	case circle, circle2, circle3
	case square, square2, square3
	case triangleOut, triangleOut2, triangleOut3, triangleOut4
	case triangleOut5
	case doubleTriangle
	case dtTT
	case triangle, triangle2, triangle3
	case triangleSharp
}

final class CustomSpinner: UIView {

	private lazy var replicatorLayer: CAReplicatorLayer = {
		let caLayer = CAReplicatorLayer()
		return caLayer
	}()

	private lazy var shapeLayer: CAShapeLayer = {
		let shapeLayer = CAShapeLayer()
		return shapeLayer
	}()

	private let keyAnimation = "opacityAnimation"

	private var type: SpinnerType = .circle

	private var superView: UIView!

	// Инициализатор с размером описывающего квадрата
	convenience init(squareLength: CGFloat, superView: UIView) {
		self.init(squareLength: squareLength, type: .circle, superView: superView)
	}

	// Инициализатор с типом спиннера
	convenience init(type: SpinnerType, superView: UIView) {
		self.init(squareLength: 100, type: type, superView: superView)
	}

	// Инициализатор с размером описывающего квадрата и типом спиннера
	convenience init(squareLength: CGFloat, type: SpinnerType, superView: UIView) {
		let mainBounds = superView.bounds//UIScreen.main.bounds
		let rect = CGRect(origin: CGPoint(x: (mainBounds.width-squareLength)/2,
										  y: (mainBounds.height-squareLength)/2),
						  size: CGSize(width: squareLength, height: squareLength))
		self.init(frame: rect)
		self.type = type
		self.superView = superView
	}

	// Инициализатор через фрейм, тип спиннера
	convenience init(frame: CGRect, type: SpinnerType, superView: UIView) {
		self.init(frame: frame)
		self.type = type
	}

	// Стандартный инициализатор через фрейм, в этом случае type = .circle
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.addSublayer(replicatorLayer)
		replicatorLayer.addSublayer(shapeLayer)
	}


	override func layoutSubviews() {
		super.layoutSubviews()

		replicatorLayer.frame = bounds
		replicatorLayer.position = CGPoint(x: bounds.width/2, y:  bounds.height/2)

		var tX = bounds.width/4
		var tY = bounds.height/4

		switch type {
		case .circle, .circle2, .circle3:
			if type == .circle2 {
				tX /= 2
				tY /= 2
			} else if type == .circle3 {
				tX /= 6
				tY /= 6
			}
			let rect = CGRect(x: bounds.width/8, y: bounds.height/8,
							  width: tX, height: tY)
			let path = UIBezierPath(ovalIn: rect)
			shapeLayer.path = path.cgPath
			shapeLayer.fillColor = UIColor.random.cgColor

		case .triangle, .triangle2, .triangle3:
			if type == .triangle2 {
				tX /= 2
				tY /= 2
			} else if type == .triangle3 {
				tX /= 4
				tY /= 4
			}
			let pathTriangle = CGMutablePath()
			let startPoint = CGPoint(x: bounds.width/8, y: bounds.width/8)
			pathTriangle.move(to: startPoint)

			let point0 = startPoint.applying(.init(translationX: 0, y: tY / 2))
			pathTriangle.move(to: point0)

			let point1 = startPoint.applying(.init(translationX: tX, y: 0))
			pathTriangle.addLine(to: point1)

			let point2 = startPoint.applying(.init(translationX: tX, y: tY))
			pathTriangle.addLine(to: point2)

			pathTriangle.addLine(to: point0)
			shapeLayer.path = pathTriangle
			shapeLayer.fillColor = UIColor.random.cgColor

		case .square, .square2, .square3:
			if type == .square2 {
				tX /= 2
				tY /= 2
			} else if type == .square3 {
				tX /= 4
				tY /= 4
			}
			let rect = CGRect(x: bounds.width/8, y: bounds.height/8, width: tX, height: tY)
			let path = UIBezierPath(rect: rect)
			shapeLayer.path = path.cgPath
			shapeLayer.fillColor = UIColor.random.cgColor

		case .triangleOut, .triangleOut2, .triangleOut3, .triangleOut4:
			if type == .triangleOut2 {
				tX /= 0.4
				tY /= 0.4
			} else if type == .triangleOut3 {
				tX /= 2
				tY /= 2
			} else if type == .triangleOut4 {
				tX /= 0.5
				tY /= -0.5
			}

			let pathTriangle = CGMutablePath()

			let startPoint = CGPoint(x: -bounds.width/8, y: bounds.width/8)
			pathTriangle.move(to: startPoint)

			//обычный
			let point4 = startPoint.applying(.init(translationX: tX, y: tY/2))
			//вытянут
//			let point4 = startPoint.applying(.init(translationX: tX, y: -tY/2))
			pathTriangle.addLine(to: point4)

			let point5 = startPoint.applying(.init(translationX: tX/2, y: tY))
			pathTriangle.addLine(to: point5)

			pathTriangle.addLine(to: startPoint)

			shapeLayer.path = pathTriangle
			shapeLayer.fillColor = UIColor.random.cgColor

		case .doubleTriangle:
			let pathTriangle = CGMutablePath()
			let startPoint = CGPoint(x: bounds.width/8, y: bounds.width/8)
			pathTriangle.move(to: startPoint, transform: .init(translationX: tX, y: tY))

			let point0 = startPoint.applying(.init(translationX: 0, y: tY/2))
			pathTriangle.addLine(to: point0)

			let point6 = startPoint.applying(.init(translationX: tX/2, y: 0))
			pathTriangle.addLine(to: point6)

			pathTriangle.addLine(to: startPoint)
			shapeLayer.path = pathTriangle
			shapeLayer.fillColor = UIColor.random.cgColor

		case .dtTT:
			let tX = bounds.width/2
			let tY = bounds.height/2

			let pathTriangle = CGMutablePath()
			let startPoint = CGPoint(x: bounds.width/8, y: bounds.width/8)
			pathTriangle.move(to: startPoint, transform: .init(translationX: tX, y: tY))

			let point0 = startPoint.applying(.init(translationX: 0, y: tY/2))
			pathTriangle.addLine(to: point0)

			let point6 = startPoint.applying(.init(translationX: tX/2, y: 0))
			pathTriangle.addLine(to: point6)

			pathTriangle.addLine(to: startPoint)
			shapeLayer.path = pathTriangle
			shapeLayer.fillColor = UIColor.random.cgColor

		case .triangleOut5:
			// triangle Down
			let pathTriangle = CGMutablePath()

			let startPoint = CGPoint(x: bounds.width/8, y: bounds.width/8)
			pathTriangle.move(to: startPoint)

			let point4 = startPoint.applying(.init(translationX: tX, y: tY/2))
			pathTriangle.addLine(to: point4)

			let point5 = startPoint.applying(.init(translationX: tX/2, y: tY))
			pathTriangle.addLine(to: point5)

			pathTriangle.addLine(to: startPoint)

			shapeLayer.path = pathTriangle
			shapeLayer.fillColor = UIColor.random.cgColor

		case .triangleSharp:
			//острые
			let pathTriangle = CGMutablePath()
			let startPoint = CGPoint(x: bounds.width/8, y: bounds.width/8)
			pathTriangle.move(to: startPoint)

			let point0 = startPoint.applying(.init(translationX: 0, y: tY / 2))
			pathTriangle.move(to: point0)

			let point1 = startPoint.applying(.init(translationX: tX, y: 0))
			pathTriangle.addLine(to: point1)

			let point3 = startPoint.applying(.init(translationX: 0, y: tY))
			pathTriangle.addLine(to: point3)

			pathTriangle.addLine(to: point0)
			shapeLayer.path = pathTriangle
			shapeLayer.fillColor = UIColor.random.cgColor
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func startAnimation(delay: TimeInterval, replicates: Int) {

		replicatorLayer.instanceCount = replicates
		let angle = CGFloat(2.0 * Double.pi) / CGFloat(replicates)
		replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)

		replicatorLayer.instanceDelay = delay

		shapeLayer.opacity = 0
		let opacityAnimation = CABasicAnimation(keyPath: "opacity")
		opacityAnimation.fromValue = 0.7
		opacityAnimation.toValue = 0
		opacityAnimation.duration = Double(replicates) * delay
		opacityAnimation.repeatCount = Float.infinity

		shapeLayer.add(opacityAnimation, forKey: keyAnimation)
	}


	func stopAnimation() {
		guard shapeLayer.animation(forKey: keyAnimation) != nil else {
			return
		}
		shapeLayer.removeAnimation(forKey: keyAnimation)
	}

	deinit {
		stopAnimation()
	}
}
