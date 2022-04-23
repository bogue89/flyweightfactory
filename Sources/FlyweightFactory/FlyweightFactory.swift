import Foundation

protocol FlyweightFactory {
    associatedtype K: Hashable
    associatedtype V

    typealias Initializer = () -> V
    static var instances: [K: V] { get set }
    static func instance(for identifier: K) -> V?
    static func instance(for identifier: K, initializer: Initializer) -> V
    static func destroy(with identifier: K)
}

extension FlyweightFactory {

    public static func instance(for identifier: K) -> V? {
        Self.instances[identifier]
    }

    public static func instance(for identifier: K, initializer: Initializer) -> V {
        Self.instances[identifier] ?? {
            let instance = initializer()
            Self.instances[identifier] = instance
            return instance
        }()
    }

    public static func destroy(with identifier: K) {
        Self.instances.removeValue(forKey: identifier)
    }
}
