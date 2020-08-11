//
//  CodeTextField.swift
//  CodeTextField
//
//  Created by xiaobin liu on 2019/4/18.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit


/// MARK - CodeTextFieldDelegate
public protocol CodeTextFieldDelegate: NSObjectProtocol {
    
    /// 值改变
    /// - Parameters:
    ///   - sender: sender
    ///   - value: valueChanged
    func codeTextField(_ sender: CodeTextField, valueChanged: String)
}


/// MARK - 验证码文本框
public class CodeTextField: UITextField, UITextFieldDelegate {
    
    /// 委托
    public weak var codeDelegate: CodeTextFieldDelegate?
    
    /// 值改变
    public var valueChanged: ((String) -> Void)?
    
    /// 验证码长度
    let codeLength: Int
    
    /// 字符标签间距
    let characterSpacing: CGFloat
    
    /// 验证字符集
    let validCharacterSet: CharacterSet
    
    /// 字符标签集合
    let characterLabels: [LableRenderable]
    
    public init(codeLength: Int,
         characterSpacing: CGFloat,
         validCharacterSet: CharacterSet,
         characterLabelGenerator: (Int) -> LableRenderable
        ) {
        
        self.codeLength = codeLength
        self.characterSpacing = characterSpacing
        self.validCharacterSet = validCharacterSet
        self.characterLabels = (0..<codeLength).map { characterLabelGenerator($0) }
        super.init(frame: CGRect.zero)
        loadSubviews()
    }
    
    
    /// 文本颜色
    override open var textColor: UIColor? {
        get { return characterLabels.first?.textColor }
        set { characterLabels.forEach { $0.textColor = newValue } }
    }
    
    /// 回调
    override open var delegate: UITextFieldDelegate? {
        get { return super.delegate }
        set { assertionFailure() }
    }
    
    
    /// 内容大小
    override open var intrinsicContentSize: CGSize {
        
        var width: CGFloat = characterSpacing * CGFloat(codeLength - 1)
        characterLabels.forEach {
            width += $0.itemSize.width
        }
        return CGSize(
            width: width,
            height: characterLabels.first?.itemSize.height ?? 0
        )
    }
    
    
    /// 控制输入光标显示的位置
    ///
    /// - Parameter position: 位置
    /// - Returns: CGRect
    override open func caretRect(for position: UITextPosition) -> CGRect {
        
        let currentEditingPosition = text?.count ?? 0
        let superRect = super.caretRect(for: position)
        
        guard currentEditingPosition < codeLength else {
            return CGRect(origin: .zero, size: .zero)
        }
        
        let width = characterLabels[currentEditingPosition].itemSize.width
        var offSet: CGFloat = 0
        (0..<currentEditingPosition).forEach { idx in
            offSet += characterLabels[idx].itemSize.width + characterSpacing
        }
        
        let x = offSet + width / 2 - superRect.width / 2
        
        return CGRect(
            x: x,
            y: superRect.minY,
            width: superRect.width,
            height: superRect.height
        )
    }
    
    /// 控制文本显示
    ///
    /// - Parameter bounds: bounds
    /// - Returns: CGRect
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let origin = super.textRect(forBounds: bounds)
        return CGRect(
            x: -bounds.width,
            y: 0,
            width: 0,
            height: origin.height
        )
    }
    
    /// 隐藏占位文字
    ///
    /// - Parameter bounds: bounds
    /// - Returns: CGRect
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return .zero
    }
    
    /// 隐藏边框
    ///
    /// - Parameter bounds: bounds
    /// - Returns: CGRect
    override open func borderRect(forBounds bounds: CGRect) -> CGRect {
        return .zero
    }
    
    
    /// 文本范围对应的选择矩形数组
    ///
    /// - Parameter range: range
    /// - Returns: [UITextSelectionRect]
    override open func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    
    /// 限制输入的字数和字符集
    ///
    /// - Parameters:
    ///   - textField: textField
    ///   - range: range
    ///   - string: string
    /// - Returns: Bool
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = text
            .map { $0 as NSString }
            .map { $0.replacingCharacters(in: range, with: string) } ?? ""
        let newTextCharacterSet = CharacterSet(charactersIn: newText)
        let isValidLength = newText.count <= codeLength
        let isUsingValidCharacterSet = validCharacterSet.isSuperset(of: newTextCharacterSet)
        if isValidLength, isUsingValidCharacterSet {
            textField.text = newText
            codeDelegate?.codeTextField(self, valueChanged: newText)
            valueChanged?(newText)
            sendActions(for: .editingChanged)
        }
        
        return false
    }
    
    
    /// 从显示的文本中删除一个字符
    override open func deleteBackward() {
        super.deleteBackward()
        sendActions(for: .editingChanged)
    }
    
    /// 第一响应者
    ///
    /// - Returns: Bool
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        defer { updateLabels() }
        return super.becomeFirstResponder()
    }
    
    
    /// 移除第一响应者
    ///
    /// - Returns: Bool
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        defer { updateLabels() }
        return super.resignFirstResponder()
    }
    
    
    /// 限制文本只处理粘贴
    ///
    /// - Parameters:
    ///   - action: action
    ///   - sender: sender
    /// - Returns: Bool
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        let paste = #selector(paste(_:))
        return action == paste
    }
    
    
    /// 复制方法
    ///
    /// - Parameter sender: sender description
    override open func paste(_ sender: Any?) {
        super.paste(sender)
        updateLabels()
    }
    
    
    /// 任何调整选择范围的行为都会直接把 insert point 调到最后一次
    override open var selectedTextRange: UITextRange? {
        get { return super.selectedTextRange }
        set { super.selectedTextRange = textRange(from: endOfDocument, to: endOfDocument) }
    }
    
    
    /// 布局子视图
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        var nextX: CGFloat = 0
        characterLabels.forEach { label in
            label.frame = CGRect(
                x: nextX,
                y: 0,
                width: label.itemSize.width,
                height: label.itemSize.height
            )
            
            nextX += (label.itemSize.width + characterSpacing)
        }
    }
    
    
    /// 加载子视图
    private func loadSubviews() {
        
        super.textColor = UIColor.clear
        clipsToBounds = true
        super.delegate = self
        addTarget(self, action: #selector(updateLabels), for: .editingChanged)
        clearsOnBeginEditing = false
        clearsOnInsertion = false
        characterLabels.forEach {
            $0.textAlignment = .center
            addSubview($0)
        }
    }
    
    /// 刷新标签
    @objc func updateLabels() {
        
        let text = self.text ?? ""
        var chars = text.map { Optional.some($0) }
        
        while chars.count < codeLength {
            chars.append(nil)
        }
        
        zip(chars, characterLabels).enumerated().forEach { args in
            let (index, (char, charLabel)) = args
            charLabel.update(
                character: char,
                isFocusingCharacter: index == text.count || (index == text.count - 1 && index == codeLength - 1),
                isEditing: isEditing
            )
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

