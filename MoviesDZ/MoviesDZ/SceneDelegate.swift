// SceneDelegate.swift
// Copyright © VTB. All rights reserved.

import UIKit
/// scene delegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let mainVC = ListFilmViewController()
        let movieApiService = MovieApiService()
        let mainViewModel = MovieViewModel(movieApiService: movieApiService)
        mainVC.setupMoViewModel(viewModel: mainViewModel)
//        mainVC.viewModel = mainViewModel

        let navController = UINavigationController(rootViewController: mainVC)
        navController.navigationBar.isTranslucent = true
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
