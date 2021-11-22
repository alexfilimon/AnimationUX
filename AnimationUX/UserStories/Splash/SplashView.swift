import UIKit

class SplashView: UIView {

    private let circleView = UIView()

    // MARK: - Methods

    func configure() {
        backgroundColor = .systemGreen

        addSubview(circleView)
        circleView.backgroundColor = .white
        circleView.layer.cornerRadius = 10
        circleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
            make.size.equalTo(20)
        }
    }

    func startAnimation(completion: @escaping () -> Void) {
        addTranslateAnimation(completion: completion)
    }

    // MARK: - Private Methods

    private func addTranslateAnimation(completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.addScaleAnimation(completion: completion)
        }

        let animationGroup = CAAnimationGroup()

        let translationAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        translationAnimation.fromValue = 0
        translationAnimation.toValue = 100

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 0.85

        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGroup.duration = 0.45
        animationGroup.repeatCount = 10
        animationGroup.autoreverses = true
        animationGroup.animations = [
            translationAnimation,
            scaleAnimation
        ]

        circleView.layer.add(animationGroup, forKey: nil)

        CATransaction.commit()
    }

    private func addScaleAnimation(completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 60
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        scaleAnimation.duration = 0.4
        circleView.transform = .init(scale: 60)
        circleView.layer.add(scaleAnimation, forKey: nil)
        CATransaction.commit()
    }


}
