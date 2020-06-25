# CodeTextField
![Lint](https://github.com/LiuSky/CodeTextField/workflows/Lint/badge.svg)
[![Version](https://img.shields.io/cocoapods/v/CodeTextField.svg?style=flat)](https://cocoapods.org/pods/CodeTextField)
[![License](https://img.shields.io/cocoapods/l/CodeTextField.svg?style=flat)](https://cocoapods.org/pods/CodeTextField)
[![Platform](https://img.shields.io/cocoapods/p/CodeTextField.svg?style=flat)](https://cocoapods.org/pods/CodeTextField)

## Requirements:
- **iOS** 9.0+
- Xcode 10.1+
- Swift 5.0

## Installation Cocoapods
<pre><code class="ruby language-ruby">pod 'CodeTextField', '~> 0.3.0'</code></pre>

## Demo Figure
<p align="center">
<img src="https://github.com/LiuSky/CodeTextField/blob/master/demo.png?raw=true" title="演示图">
</p>

## Usage
### 1. 样式1
```swift 
    private lazy var style1: CodeTextField = {
        
        let temTextField = CodeTextField(codeLength: 4,
                                         characterSpacing: 10,
                                         validCharacterSet: CharacterSet(charactersIn: "0123456789"),
                                         characterLabelGenerator: { (_) -> LableRenderable in
                                           return StyleLabel(size: CGSize(width: 50, height: 50))
        })
        temTextField.keyboardType = .numberPad
        return temTextField
    }()
```

### 2.样式2
```swift
    /// 样式2
    private lazy var style4: CodeTextField = {
        
        let temTextField = CodeTextField(codeLength: 6,
                                         characterSpacing: 10,
                                         validCharacterSet: CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"),
                                         characterLabelGenerator: { (idx) -> LableRenderable in
                                            
                                            switch idx {
                                            case 0:
                                                return StyleLabel(size: CGSize(width: 50, height: 50))
                                            case 1:
                                                let label = StyleLabel(size: CGSize(width: 50, height: 50))
                                                label.style = Style.border(nomal: UIColor.gray, selected: UIColor.blue)
                                                return label
                                            case 2:
                                                return StyleLabel(size: CGSize(width: 50, height: 50))
                                            case 3:
                                                let label = StyleLabel(size: CGSize(width: 50, height: 50))
                                                label.style = Style.border(nomal: UIColor.gray, selected: UIColor.orange)
                                                return label
                                            case 4:
                                                return StyleLabel(size: CGSize(width: 50, height: 50))
                                            default:
                                                let label = StyleLabel(size: CGSize(width: 50, height: 50))
                                                label.style = Style.border(nomal: UIColor.gray, selected: UIColor.purple)
                                                return label
                                            }
        })
        temTextField.keyboardType = .asciiCapable
        temTextField.autocorrectionType = .no
        return temTextField
    }()
```

## Reference
<ul>
<li><a href="https://kemchenj.github.io/2019-04-07/"><code>kemchenj</code></a></li>
</ul>

## License
CodeTextField is released under an MIT license. See [LICENSE](LICENSE) for more information.

