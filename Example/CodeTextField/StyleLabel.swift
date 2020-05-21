//
//  StyleLabel.swift
//  CodeTextField_Example
//
//  Created by xiaobin liu on 2020/5/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import CodeTextField

/// 风格
///
/// - line: 下划线
/// - border: 边框
public enum Style {
    
    case line(nomal: UIColor, selected: UIColor)
    case border(nomal: UIColor, selected: UIColor)
    
    public var nomal: UIColor {
        switch self {
        case let .line(nomal, _):
            return nomal
        case let .border(nomal, _):
            return nomal
        }
    }
    
    public var selected: UIColor {
        switch self {
        case let .line(_, selected):
            return selected
        case let .border(_, selected):
            return selected
        }
    }
}

/// MARK - 标签
public class StyleLabel: UILabel, CodeLable {
    
    /// 大小
    public var size: CGSize
    
    /// 风格
    public var style: Style = Style.line(nomal: UIColor.gray, selected: UIColor.red) {
        didSet {
            switch style {
            case .line:
                layer.addSublayer(lineLayer)
                lineLayer.backgroundColor = style.nomal.cgColor
                layer.borderWidth = 0
                layer.borderColor = UIColor.clear.cgColor
            default:
                lineLayer.removeFromSuperlayer()
                layer.borderWidth = 1
                layer.borderColor = style.nomal.cgColor
                layer.cornerRadius = 2
                layer.masksToBounds = true
            }
        }
    }
    
    /// 是否编辑
    private var isEditing = false
    
    /// 是否焦点
    private var isFocusingCharacter = false
    
    /// 线
    private lazy var lineLayer: CALayer = {
        let temLayer = CALayer()
        let lineHeight: CGFloat = 1
        temLayer.frame = CGRect(x: 0, y: self.size.height - lineHeight, width: self.size.width, height: lineHeight)
        temLayer.backgroundColor = self.style.nomal.cgColor
        return temLayer
    }()
    
    init(size: CGSize) {
        self.size = size
        super.init(frame: CGRect.zero)
        layer.addSublayer(lineLayer)
    }
    
    
    /// 刷新文本
    ///
    /// - Parameters:
    ///   - character: character
    ///   - isFocusingCharacter: isFocusingCharacter
    ///   - isEditing: isEditing
    public func update(character: Character?, isFocusingCharacter: Bool, isEditing: Bool) {
        
        text = character.map { String($0) }
        self.isEditing = isEditing
        self.isFocusingCharacter = isFocusingCharacter
        if (text?.isEmpty ?? true) == false || (isEditing && isFocusingCharacter) {
            switch style {
            case .line:
                lineLayer.backgroundColor = style.selected.cgColor
            default:
                layer.borderColor = style.selected.cgColor
            }
        } else {
            switch style {
            case .line:
                lineLayer.backgroundColor = style.nomal.cgColor
            default:
                layer.borderColor = style.nomal.cgColor
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



/// MARK - 自定义
public class CustomLabel: UILabel, CodeLable {

    /// 大小
    public var size: CGSize

    /// 是否编辑
    private var isEditing = false

    /// 是否焦点
    private var isFocusingCharacter = false

    /// 线
    private lazy var lineLayer: CAGradientLayer = {
        let temLayer = CAGradientLayer()
        let lineHeight: CGFloat = 1
        temLayer.frame = CGRect(x: 0, y: size.height - lineHeight, width: self.size.width, height: lineHeight)
        temLayer.colors = [UIColor.gray.cgColor,
                                UIColor.gray.cgColor,
                                UIColor.gray.cgColor]
        temLayer.locations = [0.0, 0.25, 0.5]
        temLayer.startPoint = CGPoint(x: 0, y: 0)
        temLayer.endPoint = CGPoint(x: 1, y: 1)
        return temLayer
    }()

    
    
    init(size: CGSize) {
        self.size = size
        super.init(frame: CGRect.zero)
        layer.addSublayer(lineLayer)
    }


    /// 刷新文本
    ///
    /// - Parameters:
    ///   - character: character
    ///   - isFocusingCharacter: isFocusingCharacter
    ///   - isEditing: isEditing
    public func update(character: Character?, isFocusingCharacter: Bool, isEditing: Bool) {

        text = character.map { String($0) }
        self.isEditing = isEditing
        self.isFocusingCharacter = isFocusingCharacter
        if (text?.isEmpty ?? true) == false || (isEditing && isFocusingCharacter) {
            lineLayer.colors = [UIColor.red.cgColor,
                               UIColor.green.cgColor,
                               UIColor.purple.cgColor]
            
        } else {
            
            lineLayer.colors = [UIColor.gray.cgColor,
                               UIColor.gray.cgColor,
                               UIColor.gray.cgColor]
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


/// MARK - 自定义
public class CustomBorderLabel: UILabel, CodeLable {
    
    /// 大小
    public var size: CGSize
    
    /// 是否编辑
    private var isEditing = false
    
    /// 是否焦点
    private var isFocusingCharacter = false
    
    /// 线
    private lazy var lineLayer: CAGradientLayer = {
        let temLayer = CAGradientLayer()
        let lineHeight: CGFloat = 1
        temLayer.frame = CGRect(origin: CGPoint.zero, size: self.size)
        temLayer.colors = [UIColor.gray.cgColor,
                           UIColor.gray.cgColor,
                           UIColor.gray.cgColor]
        temLayer.locations = [0.0, 0.25, 0.5]
        temLayer.startPoint = CGPoint(x: 0, y: 0)
        temLayer.endPoint = CGPoint(x: 1, y: 1)
        return temLayer
    }()
    
    
    
    init(size: CGSize) {
        self.size = size
        super.init(frame: CGRect.zero)
        layer.addSublayer(lineLayer)
    }
    
    
    /// 刷新文本
    ///
    /// - Parameters:
    ///   - character: character
    ///   - isFocusingCharacter: isFocusingCharacter
    ///   - isEditing: isEditing
    public func update(character: Character?, isFocusingCharacter: Bool, isEditing: Bool) {
        
        text = character.map { String($0) }
        self.isEditing = isEditing
        self.isFocusingCharacter = isFocusingCharacter
        if (text?.isEmpty ?? true) == false || (isEditing && isFocusingCharacter) {
            lineLayer.colors = [UIColor.red.cgColor,
                                UIColor.green.cgColor,
                                UIColor.purple.cgColor]
            
        } else {
            
            lineLayer.colors = [UIColor.gray.cgColor,
                                UIColor.gray.cgColor,
                                UIColor.gray.cgColor]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

