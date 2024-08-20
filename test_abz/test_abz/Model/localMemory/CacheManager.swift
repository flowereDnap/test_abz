//
//  CacheManager.swift
//  test_abz
//
//  Created by mac on 20.08.2024.
//

import SwiftUI
import Foundation

class CacheImageManager {
    private var imageCache: [String: UIImage] = [:]
    private var accessOrder: [String] = []
    private let cacheLimit: Int
    
    init(cacheLimit: Int = 12) {
        self.cacheLimit = cacheLimit
    }
    
    func getImage(forKey key: String) -> UIImage? {
        if let image = imageCache[key] {
            // Update access order to reflect recent access
            if let index = accessOrder.firstIndex(of: key) {
                accessOrder.remove(at: index)
                accessOrder.append(key)
            }
            return image
        }
        return nil
    }
    
    func cacheImage(_ image: UIImage, forKey key: String) {
        // If cache limit is reached, remove the oldest image
        if imageCache.count >= cacheLimit, let oldestKey = accessOrder.first {
            imageCache.removeValue(forKey: oldestKey)
            accessOrder.removeFirst()
        }
        
        imageCache[key] = image
        accessOrder.append(key)
    }
    
    func removeImage(forKey key: String) {
        imageCache.removeValue(forKey: key)
        if let index = accessOrder.firstIndex(of: key) {
            accessOrder.remove(at: index)
        }
    }
    
    func clearCache() {
        imageCache.removeAll()
        accessOrder.removeAll()
    }
}
