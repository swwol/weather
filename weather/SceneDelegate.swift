import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	private let coordinatorFactory = CoordinatorFactory(repository: WeatherRepository())
	private var appCoordinator: AppCoordinatorType!

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
	guard let navigationController = window?.rootViewController as? UINavigationController
	else { return }
		appCoordinator = coordinatorFactory.makeApp()
		appCoordinator.start(on: navigationController)
	}

	func sceneDidDisconnect(_ scene: UIScene) {
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
	}

	func sceneWillResignActive(_ scene: UIScene) {
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
	}
}
