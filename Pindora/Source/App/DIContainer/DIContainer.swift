//
//  DIContainer.swift
//  Pindora
//
//  Created by 김동현 on 9/16/25.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()
    private init() {}
    private var dependencies: [String: Any] = [:]
    
    /// 타입을 키로 하여 의존성을 등록합니다.
    /// - Parameters:
    ///   - type: 등록할 타입 (예: AuthUseCase.self)
    ///   - dependency: 실제 의존성 인스턴스 (예: AuthUseCaseImpl(...))
    func register<T>(_ type: T.Type, dependency: T) {
        let key = String(describing: type)
        dependencies[key] = dependency
    }
    
    /// 등록된 의존성을 꺼냅니다. 존재하지 않으면 앱을 중단시킵니다.
    /// - Parameter type: 꺼내고 싶은 타입
    /// - Returns: 등록된 의존성 인스턴스
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        guard let dependency = dependencies[key] as? T else {
            preconditionFailure("⚠️ \(key)는 register되지 않았습니다. resolve호출 전에 register 해주세요.")
        }
        return dependency
    }
}

@propertyWrapper
class Dependency<T> {
    let wrappedValue: T
    init() {
        self.wrappedValue = DIContainer.shared.resolve(T.self)
    }
}
