
//  WJTextView.swift
//  MyDemo
//
//  Created by 汪俊 on 16/4/1.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class WJTextView: UITextView {
    
    // 占位字符
    var MplaceString = "请输入文字！"

    // 颜色默认数值
    private var textColorValue = UIColor.blackColor()
    
    // 默认编辑字体大小
    private var fontSize:CGFloat = 16
    
    // 斜体默认数值
    private var INclineValue:CGFloat = 0.0
    
    // 下划线值
    private var UnderlineValue = 0
    
    // 加粗数据
    private var TextWidth = 0.0

    // 所在控制器
    private var VC = UIViewController()
    
    // 初始位置
    private var MyFrame = CGRect()
    
    // 初始菜单
    private var ButtonsView = UIView()
    
    
    // 颜色选择视图
    private var ColorView = UIView()
    
    // 字体视图
    private var FontView = UIView()
    
    // 添加链接的视图
    private var LinkView = UIView()
    // 网址框
    private var URLTF = UITextField()
    // 字样框
    private var PlaceTF = UITextField()
    
    // 颜色，大小, 链接页面初始化参数
    private var bool1 = false
    
    private var bool2 = false
    
    private var bool3 = false
    
    // 键盘遮盖屏幕高度
    private var KeyBoradCoverMaxY = CGFloat()
    
    // 展示状态
    private var ShowModel = false
    
    // 占位字符Label
    private var PlaceholdLabel = UILabel()
    
    // 加入链接前的字体
    private var LastTypeAttrubute = [String:AnyObject]()
    
    
    /*************************** 初始化 ***************************/
    // 代码：
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.initSelfDidAction()
    }
    
    // 可视化：
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSelfDidAction()
    }
    
    // 初始化的方法
   private func initSelfDidAction() {
        ColorView.hidden = true
        FontView.hidden = true
        LinkView.hidden = true
        ButtonsView = self.SetButtonsView()
        self.inputAccessoryView = ButtonsView
        self.addKedBoardObserver()
        self.layer.cornerRadius = 6.0
        self.clipsToBounds = true
        self.typingAttributes[NSFontAttributeName] = UIFont.systemFontOfSize((CGFloat)(fontSize))
        addPlaceHold(MplaceString)
    }
    
   // 初始化placehold
    func addPlaceHold(placeString:String) {
        PlaceholdLabel.removeFromSuperview()
        PlaceholdLabel = UILabel(frame: CGRectMake(4, 8, textContainer.size.width - textContainer.lineFragmentPadding * 2, 18))
        PlaceholdLabel.text = placeString
        PlaceholdLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
        NSNotificationCenter.defaultCenter().addObserver(self,selector: #selector(selftextDidChange),name: UITextViewTextDidChangeNotification,object: nil)
        self.addSubview(PlaceholdLabel)
    }
    
    @objc private func selftextDidChange() {
        if self.text != "" {
            PlaceholdLabel.hidden = true
        }else{
            PlaceholdLabel.hidden = false
        }
    }
    
    
    // 初始化键盘顶端功能按钮
    private func SetButtonsView() -> UIView {
        let accessView = UIView()
        accessView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 50)
        accessView.backgroundColor = UIColor(red: 0.932, green: 0.932, blue: 0.932, alpha: 1)
        return self.AddButtonsForButtonView(accessView)
    }
    
    // 添加按钮
    private func AddButtonsForButtonView(accessView:UIView) -> UIView {
        let buttonWidth = accessView.frame.width / 8
        let buttonHeight = accessView.frame.height
        let imageViewX = buttonWidth / 4
        let imageViewY = buttonHeight / 3.5
        let imageViewWidth = buttonWidth / 1.8
        let imageViewHeight = buttonWidth / 1.8
        let imageFrame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight)
        
        
        let ColorButton = UIButton()
        let ColorImageView = UIImageView(frame:imageFrame)
        ColorImageView.image = UIImage(named: "70colors")
//        ColorButton.setImage(UIImage(named: "30colors"), forState: .Normal)
        ColorButton.frame = CGRectMake(0, 0, buttonWidth, buttonHeight)
        ColorButton.addTarget(self, action: #selector(ColorButtonDidCliekd(_:)), forControlEvents: .TouchUpInside)
        ColorButton.addSubview(ColorImageView)
        
        let addImageButton = UIButton()
        let AddImageView = UIImageView(frame:imageFrame)
        AddImageView.image = UIImage(named: "70ima")
//        addImageButton.setImage(UIImage(named: "30ima"), forState: .Normal)
        addImageButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight)
        addImageButton.addTarget(self, action:#selector(addimage) , forControlEvents: .TouchUpInside)
        addImageButton.addSubview(AddImageView)
        
        let FontButton = UIButton()
        let FontImageView = UIImageView(frame:imageFrame)
        FontImageView.image = UIImage(named: "70font")
//        FontButton.setImage(UIImage(named: "30font"), forState: .Normal)
        FontButton.frame = CGRectMake(buttonWidth * 2, 0, buttonWidth, buttonHeight)
        FontButton.addTarget(self, action: #selector(FontButtonDidCliked), forControlEvents: .TouchUpInside)
        FontButton.addSubview(FontImageView)
        
        let BoldButton = UIButton()
        let BoldImageView = UIImageView(frame:imageFrame)
        BoldImageView.image = UIImage(named: "70bold")
//        BoldButton.setImage(UIImage(named: "30bold"), forState: .Normal)
        BoldButton.frame = CGRectMake(buttonWidth * 3, 0, buttonWidth, buttonHeight)
        BoldButton.addTarget(self, action: #selector(boldButtonDidCliekd), forControlEvents: .TouchUpInside)
        BoldButton.addSubview(BoldImageView)
        
        let InclineButton = UIButton()
        let InclineImageView = UIImageView(frame:imageFrame)
        InclineImageView.image = UIImage(named: "70clinder")
//        InclineButton.setImage(UIImage(named: "30clinder"), forState: .Normal)
        InclineButton.frame = CGRectMake(buttonWidth * 4, 0, buttonWidth, buttonHeight)
        InclineButton.addTarget(self, action: #selector(InclinebuttonDidCliekd), forControlEvents: .TouchUpInside)
        InclineButton.addSubview(InclineImageView)
        
        let UnderlineButton = UIButton()
        let UnderLineImageView = UIImageView(frame:imageFrame)
        UnderLineImageView.image = UIImage(named: "70Under")
//        UnderlineButton.setImage(UIImage(named: "30Under"), forState: .Normal)
        UnderlineButton.frame = CGRectMake(buttonWidth * 5, 0, buttonWidth, buttonHeight)
        UnderlineButton.addTarget(self, action: #selector(UnderLineButtonDidCliekd), forControlEvents: .TouchUpInside)
        UnderlineButton.addSubview(UnderLineImageView)
        
        let LinkButton = UIButton()
        let LinkImageView = UIImageView(frame:imageFrame)
        LinkImageView.image = UIImage(named: "70LinkB")
//        LinkButton.setImage(UIImage(named: "30Under"), forState: .Normal)
        LinkButton.frame = CGRectMake(buttonWidth * 6, 0, buttonWidth, buttonHeight)
        LinkButton.addTarget(self, action: #selector(AddLinkButtonDidCliekd), forControlEvents: .TouchUpInside)
        LinkButton.addSubview(LinkImageView)
        
        let TabelButton = UIButton()
        let TabelImageView = UIImageView(frame:imageFrame)
        TabelImageView.image = UIImage(named: "70TabelB")
        TabelButton.frame = CGRectMake(buttonWidth * 7, 0, buttonWidth, buttonHeight)
        TabelButton.addTarget(self, action: #selector(TabelButtonDidCliked), forControlEvents: .TouchUpInside)
        TabelButton.addSubview(TabelImageView)
        
        accessView.addSubview(UnderlineButton)
        accessView.addSubview(InclineButton)
        accessView.addSubview(BoldButton)
        accessView.addSubview(FontButton)
        accessView.addSubview(addImageButton)
        accessView.addSubview(ColorButton)
        accessView.addSubview(LinkButton)
        accessView.addSubview(TabelButton)
        
        return accessView
    }
    
    // 按钮的点击事件
    @objc private func ColorButtonDidCliekd(sender:UIButton) {
        self.FontView.hidden = true
        self.LinkView.hidden = true
        if bool1 == false {
            self.addColorViewToKeyBorad(ColorView)
            bool1 = true
        }
        let windows = UIApplication.sharedApplication().windows
        let top = windows.last
        top?.addSubview(ColorView)
        top?.bringSubviewToFront(ColorView)
        
        ColorView.hidden = ColorView.hidden == false ? true : false
        
//        if ColorView.hidden {
//            sender.setImage(UIImage(named: "30colors"), forState: .Normal)
//        }else{
//            sender.setImage(UIImage(named: "30colors-selected"), forState: .Normal)
//        }
    }
    
    @objc private func FontButtonDidCliked()  {
        self.ColorView.hidden = true
        self.LinkView.hidden = true
        if bool2 == false {
            self.addFontViewToKeyBorad(FontView)
            bool2 = true
        }
        let windows = UIApplication.sharedApplication().windows
        let top = windows.last
        top?.addSubview(FontView)
        top?.bringSubviewToFront(FontView)
        FontView.hidden = FontView.hidden == false ? true : false
        

    }
    
    @objc private func addimage() {
        
        self._selectImageWithAlertForGalleryOrCamera(nil)
        self.ColorView.hidden = true
        self.FontView.hidden = true
        self.LinkView.hidden = true
        
    }

   @objc private func boldButtonDidCliekd() {
        self.changeValueForBold(self.selectedRange.length)
        self.ColorView.hidden = true
        self.FontView.hidden = true
        self.FontView.hidden = true
    }
    
    @objc private func InclinebuttonDidCliekd()  {
        self.changeValueForIncline(0.5, selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
        self.FontView.hidden = true
        self.LinkView.hidden = true
    }
    
    @objc private func UnderLineButtonDidCliekd() {
        self.changeValueForUnderline(self.selectedRange.length)
        self.ColorView.hidden = true
        self.FontView.hidden = true
        self.LinkView.hidden = true
    }
    
    
    @objc private func AddLinkButtonDidCliekd() {
        self.FontView.hidden = true
        self.ColorView.hidden = true
        if bool3 == false {
            self.AddURLForStringView(LinkView)
            bool3 = true
        }
        let windows = UIApplication.sharedApplication().windows
        let top = windows.last
        top?.addSubview(LinkView)
        top?.bringSubviewToFront(LinkView)
        LastTypeAttrubute = self.typingAttributes
        
        if self.selectedRange.length != 0 {
            PlaceTF.text = self.attributedText.attributedSubstringFromRange(self.selectedRange).string
        }
        self.resignFirstResponder()
        URLTF.becomeFirstResponder()
        
        LinkView.hidden = LinkView.hidden == false ? true : false
    }
    
    @objc private func TabelButtonDidCliked() {
        let OriginalAttrbute = self.attributedText.mutableCopy()
        
        OriginalAttrbute.replaceCharactersInRange(self.selectedRange, withString: "\n    · ")
        
        self.attributedText = nil
        
        self.attributedText = OriginalAttrbute as! NSAttributedString
    }
    
    /******************** 二级菜单 *******************/
    // 添加链接菜单
    private func AddURLForStringView(LinkView:UIView) {
        LinkView.backgroundColor = UIColor(red: 0.944, green: 0.944, blue: 0.944, alpha: 1)
        LinkView.frame = CGRectMake(0, KeyBoradCoverMaxY - 100, UIScreen.mainScreen().bounds.width, 150)
        self.AddLinkTextFeils(LinkView)
    }
    
    // 颜色菜单
    private func addColorViewToKeyBorad(colorView:UIView) {
//        let windows = UIApplication.sharedApplication().windows
//        let top = windows.last
        colorView.backgroundColor = UIColor(red: 0.944, green: 0.944, blue: 0.944, alpha: 1)
        colorView.frame = CGRectMake(0, KeyBoradCoverMaxY + 50, UIScreen.mainScreen().bounds.width, 83)
        self.addColorButtons(colorView)
//        top?.bringSubviewToFront(colorView)
    }
    
    // 字体大小菜单
    private func addFontViewToKeyBorad(fontView:UIView) {
//        let windows = UIApplication.sharedApplication().windows
//        let top = windows.last
        fontView.backgroundColor = UIColor(red: 0.944, green: 0.944, blue: 0.944, alpha: 1)
        fontView.frame = CGRectMake(0, KeyBoradCoverMaxY + 50, UIScreen.mainScreen().bounds.width, 35.0)


        self.addFontSelict(fontView)
//        top?.bringSubviewToFront(fontView)
    }
    
    // MARK:添加链接输入框
    private func AddLinkTextFeils(LinkView:UIView) {
        let subWidth = LinkView.bounds.size.width
        _ = LinkView.bounds.size.height
        
        URLTF = UITextField(frame:CGRectMake(20, 20, subWidth - 40, 30))
        URLTF.placeholder = "请输入跳转网址"
        URLTF.borderStyle = .RoundedRect
        
        PlaceTF = UITextField(frame:CGRectMake(20, 70, subWidth - 40, 30))
        PlaceTF.placeholder = "请输入显示字样"
        PlaceTF.borderStyle = .RoundedRect
        
        let cancelButton = UIButton()
        cancelButton.frame = CGRectMake(20, 110, (subWidth - 80) / 2, 30)
        cancelButton.backgroundColor = UIColor(red: 0.807, green: 0.815, blue: 0.89, alpha: 1)
        cancelButton.layer.cornerRadius = 6
        cancelButton.clipsToBounds = true
        cancelButton.setTitle("取消", forState: UIControlState.Normal)
        cancelButton.addTarget(self, action: #selector(LinkCancelButtonDidCliekd), forControlEvents: .TouchUpInside)
        
        let addButton = UIButton()
        addButton.frame = CGRectMake(subWidth - cancelButton.bounds.size.width - 20, cancelButton.frame.origin.y, cancelButton.bounds.size.width, 30)
        addButton.backgroundColor = UIColor(red: 0.607, green: 0.615, blue: 0.69, alpha: 1)
        addButton.layer.cornerRadius = 6
        addButton.clipsToBounds = true
        addButton.setTitle("添加", forState: UIControlState.Normal)
        addButton.addTarget(self, action: #selector(LinkDoneButtonDidCliekd), forControlEvents: .TouchUpInside)
        
        LinkView.addSubview(URLTF)
        LinkView.addSubview(PlaceTF)
        LinkView.addSubview(cancelButton)
        LinkView.addSubview(addButton)
    }
    
    // MARK：添加颜色按钮
    private func addColorButtons(colorView:UIView) {
        let buttonWidth = colorView.frame.width / 6
        let buttonHeight = (colorView.frame.height - 13)/2
        
        let RedButton = UIButton()
        RedButton.frame = CGRectMake((buttonWidth - buttonHeight) / 2, 0, buttonHeight, buttonHeight)
        RedButton.backgroundColor = UIColor.redColor()
        RedButton.layer.cornerRadius = RedButton.frame.size.width / 2
        RedButton.clipsToBounds = true
        RedButton.layer.borderWidth = 3.0
        RedButton.layer.borderColor = UIColor.whiteColor().CGColor
        RedButton.addTarget(self, action: #selector(redButtonDid), forControlEvents: .TouchUpInside)
        
        let YellowButton = UIButton()
        YellowButton.frame = CGRectMake((buttonWidth - buttonHeight) / 2 + buttonWidth, 0, buttonHeight, buttonHeight)
        YellowButton.layer.cornerRadius = YellowButton.frame.size.width / 2
        YellowButton.clipsToBounds = true
        YellowButton.backgroundColor = UIColor.yellowColor()
        YellowButton.layer.borderWidth = 3.0
        YellowButton.layer.borderColor = UIColor.whiteColor().CGColor
        YellowButton.addTarget(self, action:#selector(yellowButtonDid) , forControlEvents: .TouchUpInside)
        
        let GreenButton = UIButton()
        GreenButton.frame = CGRectMake((buttonWidth - buttonHeight) / 2 + buttonWidth * 2, 0, buttonHeight, buttonHeight)
        GreenButton.layer.cornerRadius = GreenButton.frame.size.width / 2
        GreenButton.clipsToBounds = true
        GreenButton.backgroundColor = UIColor.greenColor()
        GreenButton.layer.borderWidth = 3.0
        GreenButton.layer.borderColor = UIColor.whiteColor().CGColor
        GreenButton.addTarget(self, action: #selector(greenButtonDid), forControlEvents: .TouchUpInside)
        
        let BlueButton = UIButton()
        BlueButton.frame = CGRectMake((buttonWidth - buttonHeight) / 2 + buttonWidth * 3, 0, buttonHeight, buttonHeight)
        BlueButton.layer.cornerRadius = BlueButton.frame.size.width / 2
        BlueButton.clipsToBounds = true
        BlueButton.backgroundColor = UIColor.blueColor()
        BlueButton.layer.borderWidth = 3.0
        BlueButton.layer.borderColor = UIColor.whiteColor().CGColor
        BlueButton.addTarget(self, action: #selector(blueButtonDid), forControlEvents: .TouchUpInside)
        
        let GragButton = UIButton()
        GragButton.frame = CGRectMake((buttonWidth - buttonHeight) / 2 + buttonWidth * 4, 0, buttonHeight, buttonHeight)
        GragButton.layer.cornerRadius = GragButton.frame.size.width / 2
        GragButton.clipsToBounds = true
        GragButton.backgroundColor = UIColor.grayColor()
        GragButton.layer.borderWidth = 3.0
        GragButton.layer.borderColor = UIColor.whiteColor().CGColor
        GragButton.addTarget(self, action: #selector(grayButtonDid), forControlEvents: .TouchUpInside)
        
        let BlackButton = UIButton()
        BlackButton.frame = CGRectMake((buttonWidth - buttonHeight) / 2 + buttonWidth * 5, 0, buttonHeight, buttonHeight)
        BlackButton.layer.cornerRadius = BlackButton.frame.size.width / 2
        BlackButton.clipsToBounds = true
        BlackButton.backgroundColor = UIColor.blackColor()
        BlackButton.layer.borderWidth = 3.0
        BlackButton.layer.borderColor = UIColor.whiteColor().CGColor
        BlackButton.addTarget(self, action: #selector(blackButtonDid), forControlEvents: .TouchUpInside)
        
        
        
        let PinkButton = UIButton()
        PinkButton.frame = CGRectMake((buttonWidth - buttonHeight) / 2 + buttonWidth * 3, buttonHeight + 8, buttonHeight, buttonHeight)
        PinkButton.backgroundColor = UIColor(red: 0.996, green: 0.512, blue: 0.968, alpha: 1)
        PinkButton.layer.cornerRadius = RedButton.frame.size.width / 2
        PinkButton.clipsToBounds = true
        PinkButton.layer.borderWidth = 3.0
        PinkButton.layer.borderColor = UIColor.whiteColor().CGColor
        PinkButton.addTarget(self, action: #selector(pinkBUtton), forControlEvents: .TouchUpInside)
        
        let BrownButton = UIButton()
        BrownButton.frame = CGRectMake((buttonWidth - buttonHeight) / 2, buttonHeight + 8, buttonHeight, buttonHeight)
        BrownButton.backgroundColor = UIColor.brownColor()
        BrownButton.layer.cornerRadius = RedButton.frame.size.width / 2
        BrownButton.clipsToBounds = true
        BrownButton.layer.borderWidth = 3.0
        BrownButton.layer.borderColor = UIColor.whiteColor().CGColor
        BrownButton.addTarget(self, action: #selector(brownBUttonDid), forControlEvents: .TouchUpInside)
        
        let OrangiButton = UIButton()
        OrangiButton.frame = CGRectMake((buttonWidth - buttonHeight) / 2 + buttonWidth, buttonHeight + 8, buttonHeight, buttonHeight)
        OrangiButton.backgroundColor = UIColor(red: 0.98, green: 0.756, blue: 0.356, alpha: 1)
        OrangiButton.layer.cornerRadius = RedButton.frame.size.width / 2
        OrangiButton.clipsToBounds = true
        OrangiButton.layer.borderWidth = 3.0
        OrangiButton.layer.borderColor = UIColor.whiteColor().CGColor
        OrangiButton.addTarget(self, action: #selector(orignButtonDid), forControlEvents: .TouchUpInside)
        
        let PupolButton = UIButton()
        PupolButton.frame = CGRectMake((buttonWidth - buttonHeight) / 2 + buttonWidth * 2, buttonHeight + 8, buttonHeight, buttonHeight)
        PupolButton.backgroundColor = UIColor(red: 0.537, green: 1, blue: 0.96, alpha: 1)
        PupolButton.layer.cornerRadius = RedButton.frame.size.width / 2
        PupolButton.clipsToBounds = true
        PupolButton.layer.borderWidth = 3.0
        PupolButton.layer.borderColor = UIColor.whiteColor().CGColor
        PupolButton.addTarget(self, action: #selector(SkyButtonDid), forControlEvents: .TouchUpInside)
        
        let SkyBUtton = UIButton()
        SkyBUtton.frame = CGRectMake((buttonWidth - buttonHeight) / 2 + buttonWidth * 4, buttonHeight + 8, buttonHeight, buttonHeight)
        SkyBUtton.backgroundColor = UIColor(red: 0.701, green: 0.384, blue: 1, alpha: 1)
        SkyBUtton.layer.cornerRadius = RedButton.frame.size.width / 2
        SkyBUtton.clipsToBounds = true
        SkyBUtton.layer.borderWidth = 3.0
        SkyBUtton.layer.borderColor = UIColor.whiteColor().CGColor
        SkyBUtton.addTarget(self, action: #selector(populBUttonDid), forControlEvents: .TouchUpInside)
        
        let LightGray = UIButton()
        LightGray.frame = CGRectMake((buttonWidth - buttonHeight) / 2 + buttonWidth * 5, buttonHeight + 8, buttonHeight, buttonHeight)
        LightGray.backgroundColor = UIColor(red: 0.772, green: 0.772, blue: 0.772, alpha: 1)
        LightGray.layer.cornerRadius = RedButton.frame.size.width / 2
        LightGray.clipsToBounds = true
        LightGray.layer.borderWidth = 3.0
        LightGray.layer.borderColor = UIColor.whiteColor().CGColor
        LightGray.addTarget(self, action: #selector(lightGrayButtonDid), forControlEvents: .TouchUpInside)
        
        colorView.addSubview(BlackButton)
        colorView.addSubview(GragButton)
        colorView.addSubview(BlueButton)
        colorView.addSubview(GreenButton)
        colorView.addSubview(YellowButton)
        colorView.addSubview(RedButton)
        colorView.addSubview(PinkButton)
        colorView.addSubview(BrownButton)
        colorView.addSubview(OrangiButton)
        colorView.addSubview(PupolButton)
        colorView.addSubview(SkyBUtton)
        colorView.addSubview(LightGray)
        
//        return colorView
    }
    
    // MARK:大小菜单
    private func addFontSelict(fontView:UIView) {
        let slider = UISlider(frame: CGRectMake(30, 0, fontView.frame.width - 60, fontView.frame.height))
        slider.minimumValue = 5
        slider.maximumValue = 60
//        slider.value = 18
        if self.selectedRange.length == 0 {
           slider.setThumbImage(self.changeValueForSliderKey("14"), forState:.Normal)
            slider.value = 16
            
        }
        
        
        slider.addTarget(self, action: #selector(sliderChangeValue(_:)), forControlEvents:UIControlEvents.ValueChanged)
        
        
        
        let minLable = UILabel()
        minLable.frame = CGRectMake(0, 0, 30, fontView.frame.height)
        minLable.text = "5"
        minLable.font = UIFont(name: "Helvetica", size: 13)
        minLable.textColor = UIColor.grayColor()
        minLable.textAlignment = .Center


        let maxLable = UILabel()
        maxLable.frame = CGRectMake(fontView.frame.width - 30, 0, 30, fontView.frame.height)
        maxLable.text = "60"
        maxLable.font = UIFont(name: "Helvetica", size: 13)
        maxLable.textColor = UIColor.grayColor()
        maxLable.textAlignment = .Center
        
        fontView.addSubview(slider)
        fontView.addSubview(minLable)
        fontView.addSubview(maxLable)
        
        
    }
    
    /************************* 大小滑块滑动事件 *************************/
    
    func sliderChangeValue(sender:UISlider) {
        
        let senderValue = Int(sender.value)
        
        let senderFloat = CGFloat(senderValue)
        

        print(senderFloat)
        
        sender.setThumbImage(self.changeValueForSliderKey("\(senderValue)"), forState: UIControlState.Normal)
        
        self.SetValueForTextFont(senderFloat, selectedLength: self.selectedRange.length)
    }
    
    // 改变滑块显示的图
    private func changeValueForSliderKey(valueStr:String) -> UIImage {
        let image = UIImage(named: "30key")
        UIGraphicsBeginImageContext(image!.size)
//        let ctx = UIGraphicsGetCurrentContext()
        image?.drawAtPoint(CGPointZero)
        let str = valueStr
        str.drawAtPoint(CGPointMake(7.5, 6),withAttributes: nil)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    
    /***************** 颜色按钮 **********************/
    @objc private func redButtonDid() {
        self.changeValueForColor(UIColor.redColor(), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    @objc private func yellowButtonDid() {
        self.changeValueForColor(UIColor.yellowColor(), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    @objc private func greenButtonDid() {
        self.changeValueForColor(UIColor.greenColor(), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    @objc private func blueButtonDid() {
        self.changeValueForColor(UIColor.blueColor(), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    @objc private func grayButtonDid() {
        self.changeValueForColor(UIColor.grayColor(), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    @objc private func blackButtonDid() {
        self.changeValueForColor(UIColor.blackColor(), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    
    @objc private func brownBUttonDid() {
        self.changeValueForColor(UIColor.brownColor(), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    
    @objc private func orignButtonDid() {
        self.changeValueForColor(UIColor(red: 0.98, green: 0.756, blue: 0.356, alpha: 1), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    
    @objc private func SkyButtonDid()  {
        self.changeValueForColor(UIColor(red: 0.537, green: 1, blue: 0.96, alpha: 1), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    
    @objc private func pinkBUtton()  {
        self.changeValueForColor(UIColor(red: 0.996, green: 0.512, blue: 0.968, alpha: 1), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    @objc private func populBUttonDid() {
        self.changeValueForColor(UIColor(red: 0.701, green: 0.384, blue: 1, alpha: 1), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    @objc private func lightGrayButtonDid() {
        self.changeValueForColor(UIColor(red: 0.772, green: 0.772, blue: 0.772, alpha: 1), selectedLength: self.selectedRange.length)
        self.ColorView.hidden = true
    }
    
    /********************** 链接按钮 *************************/
    @objc private func LinkCancelButtonDidCliekd(sender:UIButton) {
        URLTF.text = nil
        PlaceTF.text = nil
        LinkView.endEditing(true)
        LinkView.hidden = true
        self.endEditing(true)
    }
    
    @objc private func LinkDoneButtonDidCliekd(sender:UIButton) {
        
        if URLTF.text != "" {
            let originalText = self.attributedText.mutableCopy()
            if PlaceTF.text != "" {
                let AddAttributeLink = AddLinkWithAttributestring(URLTF.text!, PlaceHoldString: PlaceTF.text!)
                originalText.replaceCharactersInRange(self.selectedRange, withAttributedString: AddAttributeLink)
                self.attributedText = nil
                self.attributedText = originalText as! NSAttributedString
                self.typingAttributes = LastTypeAttrubute
                URLTF.text = nil
                PlaceTF.text = nil
                LinkView.endEditing(true)
                LinkView.hidden = true
                 self.endEditing(true)
                
            }else{
                let AddAttributeLink = AddLinkWithAttributestring(URLTF.text!, PlaceHoldString: URLTF.text!)
                originalText.replaceCharactersInRange(self.selectedRange, withAttributedString: AddAttributeLink)
                self.attributedText = nil
                self.attributedText = originalText as! NSAttributedString
                self.typingAttributes = LastTypeAttrubute
                URLTF.text = nil
                PlaceTF.text = nil
                LinkView.endEditing(true)
                LinkView.hidden = true
                 self.endEditing(true)
            }
            
        }else{
            let AlertController = UIAlertController(title: "网址不能为空！", message:nil, preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "确定", style: .Default, handler: nil)
            AlertController.addAction(alertAction)
            let vc = self.getInvoker(self)
            vc.presentViewController(AlertController, animated: true, completion: nil)
            
        }
        
        
    }
    
    /**********：获取当前所在的控制器 ****************/
    private func getInvoker(view:UIView) -> UIViewController {
        
        var res: UIResponder!
        var re = view.superview?.nextResponder()
        
        repeat {
            
            res = re
            re = re?.nextResponder()
            
        } while !res.isKindOfClass(UIViewController)
        
        return res as! UIViewController
    }
    
    
    /******************************* 监听事件 *******************************/
    private func addKedBoardObserver() {
        // 键盘出现
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(KeyBoardWillAppear(_:)), name: UIKeyboardWillShowNotification, object: nil)
        // 键盘隐藏
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        // 结束编辑
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(selfDidEndEditing(_:)), name: UITextViewTextDidEndEditingNotification, object: nil)
        
        // 编辑过程
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WhenEditingDidCliekd(_:)), name: UITextViewTextDidChangeNotification, object: nil)
        
    }
    
    
    @objc private func KeyBoardWillAppear(notification:NSNotification) {
        
        MyFrame = self.frame
    
        if self.isFirstResponder() {
            
            
            VC  = self.getInvoker(self)
            
            let change = self.KeyboardEndingFrameHeight(notification.userInfo!).height
            
            KeyBoradCoverMaxY = UIScreen.mainScreen().bounds.height - change
            
            // 弹出二层视图预留高度
            var contect = self.contentInset
            
            let Value = change - (UIScreen.mainScreen().bounds.height - self.frame.maxY)
            if Value > 0 {
                contect.bottom = Value
            }
            
            self.contentInset = contect
            
        }
      
    }
    
    @objc private func keyboardWillDisappear(notification:NSNotification) {
        if self.isFirstResponder() {
          self.frame = MyFrame
          self.ColorView.hidden = true
          self.FontView.hidden = true
          self.LinkView.hidden = true
        }
    }
    
    @objc private func KeyboardEndingFrameHeight(userInfo:NSDictionary) -> CGRect {
        
        let kayboardEndingUncorrectedFrame = userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue()
        
        let kayboardEndingFrame = VC.view.convertRect(kayboardEndingUncorrectedFrame!, toView: nil)
        
        return kayboardEndingFrame
        
    }
    
    
    @objc private func selfDidEndEditing(textView: UITextView) {
        self.frame = MyFrame
        self.ColorView.hidden = true
        self.FontView.hidden = true
        self.LinkView.hidden = true
        
    }
    
    @objc private func WhenEditingDidCliekd(textView:UITextView) {
        if self.typingAttributes[NSLinkAttributeName] != nil{
            self.typingAttributes[NSLinkAttributeName] = nil
        }
    }
    
    /***************************** 编辑模块 ******************************/
    
    // MARK:斜体处理(参数：1.倾斜程度：0~1， 2.self.textView.selectedRange.length)
    private func changeValueForIncline(value:CGFloat, selectedLength:Int) {
        if selectedLength == 0 {
            self.typingAttributes[NSObliquenessAttributeName] = (self.typingAttributes[NSObliquenessAttributeName] as? NSNumber == 0) || (self.typingAttributes[NSObliquenessAttributeName] as? NSNumber == nil) ? 0.5 : 0
        }else{
            let mutStr = self.attributedText.mutableCopy()
            
            let returnRange = self.selectedRange
            
            var TextRange = self.selectedRange
            
            let string = mutStr as! NSAttributedString
            
            let textss = string.attributedSubstringFromRange(self.selectedRange)
            
            let dixt = textss.attributesAtIndex(1, effectiveRange: &TextRange)
        
            INclineValue = 0.5
            
            for Item in dixt {
                if Item.0 == "NSObliqueness" && Item.1 as! NSObject == 0.5 {
                
                   INclineValue = 0.0
                   

                }
                
            }

            mutStr.addAttribute(NSObliquenessAttributeName, value: INclineValue, range: self.selectedRange)
            
            self.attributedText = mutStr.copy() as! NSAttributedString
            
            self.selectedRange = NSMakeRange(returnRange.location, returnRange.length)
            
            self.scrollRangeToVisible(NSMakeRange(returnRange.location, returnRange.length))
            
            
        }
        
    }
    
    
    
    // MARK:颜色处理(参数：1.颜色，2.self.textView.selectedRange.length)
    private func changeValueForColor(color:UIColor, selectedLength:Int) {
        if selectedLength == 0 {
            /*   需要单色来回切换模式:
            textColorValue = textColorValue == UIColor.blackColor() ? color : UIColor.blackColor()
           self.typingAttributes[NSForegroundColorAttributeName] = textColorValue
            */
            
            //   多颜色渲染模式:
            self.typingAttributes[NSForegroundColorAttributeName] = color
 
        }else{
            let mutStr = self.attributedText.mutableCopy()
            
            let textRange = self.selectedRange
            
            mutStr.addAttribute(NSForegroundColorAttributeName, value: color, range: textRange)
            
            self.attributedText = mutStr.copy() as! NSAttributedString
            
            self.selectedRange = NSMakeRange(textRange.location, textRange.length)
            
            self.scrollRangeToVisible(NSMakeRange(textRange.location, textRange.length))
            
        }
    }
    
    // MARK:改变字体大小（参数：1.改变字体大小的数值，2.2.self.textView.selectedRange.length， 3.改变的方法0：变大，非0：变小）
    private func changeValueForTextSize(changeSize:CGFloat, selectedLength:Int, changeWay:Int)  {
        if selectedLength == 0 {
            if changeWay == 0 {
                fontSize += changeSize
            }else{
                fontSize -= changeSize
            }
            self.typingAttributes[NSFontAttributeName] = UIFont.systemFontOfSize((CGFloat)(fontSize))
        }else{
            let mutStr = self.attributedText.mutableCopy()
            let returnRange = self.selectedRange
            
            var TextRange = self.selectedRange
            
            let string = mutStr as! NSAttributedString
            
            let textss = string.attributedSubstringFromRange(self.selectedRange)
            
            let dixt = textss.attributesAtIndex(1, effectiveRange: &TextRange)
            
            for Item in dixt {
                if Item.0 == "NSFont" {
                    let aa = Item.1
                    var value = (aa.fontDescriptor().fontAttributes()["NSFontSizeAttribute"])! as! CGFloat
                    if changeWay == 0 {
                        value += changeSize
                    }else{
                        value -= changeSize
                    }
                    mutStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(value), range: self.selectedRange)
                }
                
                
            }
            
            
            
            self.attributedText = string
            
            
            self.selectedRange = NSMakeRange(returnRange.location, returnRange.length)
            
            self.scrollRangeToVisible(NSMakeRange(returnRange.location, TextRange.length))
        }
    }
    
    // MARK：设置字体大小
    private func SetValueForTextFont(changeSize:CGFloat, selectedLength:Int) {
        if selectedLength == 0 {
            
            fontSize = changeSize
            
            self.typingAttributes[NSFontAttributeName] = UIFont.systemFontOfSize((CGFloat)(fontSize))
            
        }else{
            let mutStr = self.attributedText.mutableCopy()
            let returnRange = self.selectedRange
            
            var TextRange = self.selectedRange
            
            let string = mutStr as! NSAttributedString
            
            let textss = string.attributedSubstringFromRange(self.selectedRange)
            
            let dixt = textss.attributesAtIndex(1, effectiveRange: &TextRange)
            
            for Item in dixt {
                if Item.0 == "NSFont" {
                    let aa = Item.1
                    var value = (aa.fontDescriptor().fontAttributes()["NSFontSizeAttribute"])! as! CGFloat
                    
                    value = changeSize
                    
                    mutStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(value), range: self.selectedRange)
                }
                
                
            }
            
            
            
            self.attributedText = string
            
            
            self.selectedRange = NSMakeRange(returnRange.location, returnRange.length)
            
            self.scrollRangeToVisible(NSMakeRange(returnRange.location, TextRange.length))
        }

    }
    
    // MARK:下划线（参数1.self.textView.selectedRange.length）
    private func changeValueForUnderline(selectedLength:Int) {
        if selectedLength == 0 {
            self.typingAttributes[NSUnderlineStyleAttributeName] = ((self.typingAttributes[NSUnderlineStyleAttributeName] as? NSNumber) == 0 || (self.typingAttributes[NSUnderlineStyleAttributeName] as? NSNumber) == nil) ? 1 : 0
        }else{
            let mutStr = self.attributedText.mutableCopy()
            
            let returnRange = self.selectedRange
            
            var TextRange = self.selectedRange
            
            let string = mutStr as! NSAttributedString
            
            let textss = string.attributedSubstringFromRange(self.selectedRange)
            
            let dixt = textss.attributesAtIndex(1, effectiveRange: &TextRange)
            
            UnderlineValue = 1
            
            for Item in dixt {
                if Item.0 == "NSUnderline" && Item.1 as! NSObject == 1 {
                    
                    UnderlineValue = 0
                }
                
            }
            
            mutStr.addAttribute(NSUnderlineStyleAttributeName, value: UnderlineValue, range: self.selectedRange)
            
            self.attributedText = mutStr.copy() as! NSAttributedString
            
            self.selectedRange = NSMakeRange(returnRange.location, returnRange.length)
            
            self.scrollRangeToVisible(NSMakeRange(returnRange.location, returnRange.length))
        }

    }
    
    // MARK:粗体按钮（参数：1.self.textView.selectedRange.length）
    private func changeValueForBold(selectedLength:Int) {
        if selectedLength == 0 {
            self.typingAttributes[NSStrokeWidthAttributeName] = ((self.typingAttributes[NSStrokeWidthAttributeName] as? NSNumber) == 0.0 || (self.typingAttributes[NSStrokeWidthAttributeName] as? NSNumber) == nil) ? -3.0 : 0.0
        }else{
            let mutStr = self.attributedText.mutableCopy()
            
            let returnRange = self.selectedRange
            
            var TextRange = self.selectedRange
            
            let string = mutStr as! NSAttributedString
            
            let textss = string.attributedSubstringFromRange(self.selectedRange)
            
            let dixt = textss.attributesAtIndex(1, effectiveRange: &TextRange)
            
            TextWidth = -3.0
            
            for Item in dixt {
                if Item.0 == "NSStrokeWidth" && Item.1 as! NSObject == -3.0 {
                    
                    TextWidth = 0.0
                }
                
            }
            
            mutStr.addAttribute(NSStrokeWidthAttributeName, value: TextWidth, range: self.selectedRange)
            
            self.attributedText = mutStr.copy() as! NSAttributedString
            
            self.selectedRange = NSMakeRange(returnRange.location, returnRange.length)
            
            self.scrollRangeToVisible(NSMakeRange(returnRange.location, returnRange.length))
        }
    }
    
    
    // 字符串添加链接
    private func AddLinkWithAttributestring(URLTFString:String, PlaceHoldString:String) -> NSAttributedString {
        
        let URLString = "http://" + URLTFString
        
        let attributeDict:[String:AnyObject] = [NSLinkAttributeName:NSURL.init(string: URLString)!,NSFontAttributeName:UIFont.systemFontOfSize((CGFloat)(fontSize)),NSUnderlineStyleAttributeName:1]
        
        let attributestringWithURL = NSAttributedString(string:PlaceHoldString, attributes: attributeDict)
        
        return attributestringWithURL
    }
    
    
    
    
    /************************* 文本处理 **************************/
    // MARK: - 获取textView的AttributeString
    func getAttributeStringFromTextView() -> NSAttributedString {
        let attributeString = self.attributedText.mutableCopy() as! NSAttributedString
        return attributeString
    }
    
    // MARK:获取图片数组
    func getPicturesArray() -> NSArray {
        return self.attachedImages()
    }
    
    // MARK:获取无图片富文本
    func getNilImagesAttributeString() -> NSAttributedString {
        let nilImageAttribute = self.attributedText.mutableCopy() as! NSAttributedString
        
        nilImageAttribute.enumerateAttribute(NSAttachmentAttributeName, inRange: NSMakeRange(0, nilImageAttribute.length), options: .Reverse, usingBlock: { (value , range, stop) in
            if (value != nil) {
                let attachment = value as! NSTextAttachment
                attachment.image = nil
            }
        })
        return nilImageAttribute
        
    }
   
    
    /***************************** 展示模块 ******************************/
    
    // MARK:展示本地传值文本数据（参数：富文本对象）
//    func showLocalAttributeString(attributeString:NSAttributedString) {
////        MyFrame = self.frame
//        PlaceholdLabel.hidden = true
//        self.selectable = false
//        self.scrollEnabled = false
//        self.attributedText = attributeString
//        self.changeSelfHeightWithAttributestring()
//        
//    }
    
    
    // MARK:展示网络请求文本数据
    func showNetAttributeString(nilImageAttributeString:NSAttributedString, array:[String])  {
//        self.selectable = false
        self.scrollEnabled = false
        self.editable = false
        PlaceholdLabel.hidden = true
        
        
        let changeAttributeString = nilImageAttributeString.copy()
        
        
        changeAttributeString.enumerateAttribute(NSAttachmentAttributeName, inRange: NSMakeRange(0, changeAttributeString.length), options: .Reverse ,usingBlock: { (value, range, stop) in
            if (value != nil) {
                let attachment = value as! NSTextAttachment
                
                let images = UIImage(named: "70place")
                
                attachment.bounds = self.scaleImageSizeToWidth(self.bounds.size.width, image: images!)
                
                attachment.image = UIImage(named: "70place")
                
            }
        })
        
        self.attributedText = changeAttributeString as! NSAttributedString
        
        self.changeSelfHeightWithAttributestring()
        
        self.backgroundWork(nilImageAttributeString, array: array)
        
    }
    
    // MARK:后台加载图片
    func backgroundWork(nilImageAttributeString:NSAttributedString, array:[String]) {
        var imageIndex = 0
        
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            nilImageAttributeString.enumerateAttribute(NSAttachmentAttributeName,
                                               inRange: NSMakeRange(0, nilImageAttributeString.length),
                                               
                                               options:.Reverse,
                                               
                                               usingBlock: { (value , range, stop) in
                                                if (value != nil) {
                                                    let attachment = value as! NSTextAttachment
                                                    let images = self.addNetPictures(array[imageIndex])
                                                    attachment.bounds = self.scaleImageSizeToWidth(self.bounds.size.width, image: images)
                                                    attachment.image = images
                                                    imageIndex += 1
                                                }
            })
            dispatch_async(dispatch_get_main_queue(), {
                // 清除缓存
                self.attributedText = nil
                
                self.attributedText = nilImageAttributeString
                
                self.changeSelfHeightWithAttributestring()
            })
            
        }
        
    }
  
    
    // MARK:后台加载图片
    func addNetPictures(path:String) -> UIImage {
        var backImage = UIImage()
        
        let url = NSURL(string: path)
        let Vdata = NSData(contentsOfURL: url!)
        if Vdata == nil {
            return UIImage(named: "234")!
        }else{
        
        backImage = UIImage(data: Vdata!)!
        
        return backImage
        }
    }

    
    // MARK:图片处理
    func scaleImageSizeToWidth(width:CGFloat , image:UIImage) -> CGRect {
        let factor = CGFloat(width / image.size.width)
        return CGRectMake(0, 0, image.size.width * factor - 10, image.size.height * factor)
    }
    
    
    
    
    // MARK;刷新改变高度
    func changeSelfHeightWithAttributestring() {
        let fixedWidth = self.frame.size.width
        
        self.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        
        let newSize = self.sizeThatFits(CGSizeMake(fixedWidth, CGFloat.max))
        
        var newFrame = self.frame
        
        newFrame.size = CGSizeMake(max(newSize.width, fixedWidth), newSize.height)
        
        self.frame = newFrame
    }
    
    
    //MARK: - 控制图片大小
    private func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
}
