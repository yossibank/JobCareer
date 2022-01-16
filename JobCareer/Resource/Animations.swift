import Lottie
import UIKit

enum Animations: String {
    case penguin
}

extension UIView {

    func setAnimation(animation: Animations, loopMode: LottieLoopMode = .playOnce) {
        let animationView = AnimationView(name: animation.rawValue)

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        addSubViews(
            animationView,

            constraints:
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor)
        )
    }
}
