//
//  ModuleFactory.swift
//  Pindora
//
//  Created by 김동현 on 9/16/25.
//

import Foundation

enum ModuleKey: String {
    // MARK: - Login
    case login
    case oneTimeAsk
    
    // MARK: - MainTab
    case home
}

// MARK: - ModuleFactory
/// ViewController 및 ViewModel을 생성하고, ViewModel을 캐싱하여 재사용하는 역할을 하는 팩토리 클래스입니다.
/// MVVM-C 아키텍처에서 Coordinator가 ViewController를 생성할 때 사용합니다.
final class ModuleFactory {
    static let shared = ModuleFactory()
    private init() {}
    private var viewModelCache: [ModuleKey: Any] = [:]
    
    private func getOrCreateViewModel<T>(for key: ModuleKey, factory: () -> T) -> T {
        if let cached = viewModelCache[key] as? T {
            return cached
        }
        let newVM = factory()
        viewModelCache[key] = newVM
        return newVM
    }
    
    /// 특정 ViewModel만 캐시에서 제거합니다.
    /// 주로 로그아웃, 상태 초기화 시 사용됩니다.
    func removeViewModel(for key: ModuleKey) {
        viewModelCache[key] = nil
    }
    
    /// 모든 ViewModel 캐시를 초기화합니다.
    /// 주로 앱 리셋, 사용자 전환 시 사용됩니다.
    func clearAllViewModel() {
        viewModelCache.removeAll()
    }
}

extension ModuleFactory {

}


