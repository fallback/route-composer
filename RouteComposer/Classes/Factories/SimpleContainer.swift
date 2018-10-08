//
// Created by Eugene Kazaev on 07/09/2018.
//

import Foundation
import UIKit

/// A helper protocol to the `Container` protocol. If a container does not need to deal with the children view
/// controller creation, `SimpleContainer` will handle integration of the children view controllers.
public protocol SimpleContainer: Container {

    /// Type of the `UIViewController` that `SimpleContainer` can build
    associatedtype ViewController = ViewController

    /// Type of context `Context` instance that `SimpleContainer` needs
    associatedtype Context = Context

    /// Builds a `UIViewController` that will be integrated into the stack
    ///
    /// Parameters:
    ///   - context: A `Context` instance provided to the `Router`.
    ///   - viewControllers: `UIViewController` instances to be integrated into the container as children view controllers
    /// - Returns: The built `UIViewController` container instance.
    /// - Throws: The `RoutingError` if the build does not succeed.
    func build(with context: Context, integrating viewControllers: [UIViewController]) throws -> ViewController

}

public extension SimpleContainer {

    /// Default implementation of the `Container`'s `build` method
    func build(with context: Context, integrating coordinator: ChildCoordinator<Context>) throws -> ViewController {
        let viewControllers = try coordinator.build(with: context)
        return try build(with: context, integrating: viewControllers)
    }

}
