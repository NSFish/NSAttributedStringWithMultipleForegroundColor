## Using NSAttributedString with multiple foregroundColor makes the text in UILabel look lower than expected ##

[Stack Overflow](https://stackoverflow.com/questions/54647527/using-nsattributedstring-with-multiple-foregroundcolor-makes-the-text-in-uilabel)

### Description ###

Here I have a UILabel as simple as it could be

    let label = UILabel()
    label.backgroundColor = UIColor.gray
    label.numberOfLines = 2
    view.addSubview(label)
    // autolayout stuff..
And an NSAttributedString configured to meet the designer's intent

    let content = " 自营  回力/WARRIOR 轮胎 215/65R16 98H SR1"
    let attributedText = NSMutableAttributedString.init(string: content)
    let font = UIFont.systemFont(ofSize: 16)
    let baselineOffset = (lineHeight - font.lineHeight) / 4
    let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font,
                                                      NSAttributedString.Key.foregroundColor: UIColor.black,
                                                      NSAttributedString.Key.baselineOffset: Int(baselineOffset)]
    
    attributedText.setAttributes(attributes, range: NSRange.init(location: 0, length: content.count))
            
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.maximumLineHeight = lineHeight
    paragraphStyle.minimumLineHeight = lineHeight
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange.init(location: 0, length: content.count))
            
    label.attributedText = attributedText

The content string showed up in the center of the UILabel, just as expected. But when I changed the first two chars' foregroundColor, things started to go wrong

    // text looks lower
    var prefixAttributes = attributes
    prefixAttributes[NSAttributedString.Key.foregroundColor] = UIColor.white
    attributedText.setAttributes(prefixAttributes, range: NSRange.init(location: 0, length: 5))
    attributedText.setAttributes(attributes, range: NSRange.init(location: 5, length: content.count - 5))
    // text in the center, works
    // attributedText.setAttributes(attributes, range: NSRange.init(location: 0, length: content.count))

The only difference here is the foregroundColor at range(0, 5) changed to white.

### Result ###

[![before][1]][1]
[![after][2]][2]

### Question ###

I'm not very familiar with TextKit, but I do know the position of the text inside a UILabel is supposed to be decided by baselineOffset, or at least something, anything, but the foregroundColor of the text...

[1]: https://i.stack.imgur.com/hYZUi.png
[2]: https://i.stack.imgur.com/fnLyG.png