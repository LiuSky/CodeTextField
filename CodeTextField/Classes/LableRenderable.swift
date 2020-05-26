//
//  LableRenderable.swift
//  CodeTextField
//
//  Created by xiaobin liu on 2019/4/18.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit
import Foundation

/// MARK - 组合协议
public typealias LableRenderable = UILabel & CodeLable

/// MARK - 验证码文本协议
public protocol CodeLable {
    
    /// 大小
    var itemSize: CGSize { get }
    
    /// 刷新方法
    ///
    /// - Parameters:
    ///   - character: 字符
    ///   - isFocusingCharacter: 是否焦点
    ///   - isEditing: 是否编辑
    func update(character: Character?, isFocusingCharacter: Bool, isEditing: Bool)
}

