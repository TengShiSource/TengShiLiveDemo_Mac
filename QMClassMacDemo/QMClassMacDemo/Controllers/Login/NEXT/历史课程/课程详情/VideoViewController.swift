//
//  VideoViewController.swift
//  QMClassMac
//
//  Created by penguin on 2021/8/5.
//

import Cocoa
import AVKit

class VideoViewController: NSViewController {
    
    lazy var rightContainerView: NSView = {
        let view = NSView()
        return view
    }()
    
    /// 标题（课程名称）
    lazy var titleLabel: NSTextField = {
        let label = NSTextField(wrappingLabelWithString: "")
        label.isEnabled = false
        label.isSelectable = false
        label.backgroundColor = .white
        label.font = NSFont.systemFont(ofSize: 18)
        label.alignment = .left
        //最多显示行数
        label.maximumNumberOfLines = 0
        // 设置断行模式
        label.cell?.lineBreakMode = .byTruncatingTail

        return label
    }()
    
    /// 老师头像
    lazy var avatarImageView: NSImageView = {
        let view = NSImageView()
        view.wantsLayer = true
        view.imageScaling = .scaleAxesIndependently
        view.layer?.backgroundColor = NSColor.orange.cgColor
        view.image = NSImage(named: "Default_UserAvatar")
        return view
    }()
    
    /// 名字
    lazy var nameLabel: NSTextField = {
        let label = NSTextField(wrappingLabelWithString: "")
        label.backgroundColor = .white
        label.font = NSFont.systemFont(ofSize: 14)
        label.alignment = .left
        //最多显示行数
        label.maximumNumberOfLines = 1
        // 设置断行模式
        label.cell?.lineBreakMode = .byTruncatingTail
        // 设置是否启用单行模式
        label.cell?.usesSingleLineMode = true
        // 设置超出行数是否隐藏
        label.cell?.truncatesLastVisibleLine = true
        return label
    }()
    
    lazy var datalist:[VideoNumberModel] = []
    
    lazy var collectionView: NSCollectionView = {
        let layout = NSCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = NSCollectionView()
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColors = [.clear]
        collectionView.allowsMultipleSelection = false
        collectionView.isSelectable = true
        collectionView.register(VideoNumberItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier.init(rawValue: "VideoNumberItem"))
        return collectionView
    }()
    
    lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.documentView = collectionView
        scrollView.scrollerStyle = NSScroller.Style.overlay
        scrollView.horizontalScrollElasticity = .automatic
        scrollView.verticalScrollElasticity = .automatic
        scrollView.hasVerticalScroller = true
        scrollView.scrollerKnobStyle = .default
        return scrollView
    }()
    
    lazy var playerView: AVPlayerView = {
        let view = AVPlayerView()
        view.videoGravity = .resizeAspect
        return view
    }()
    
    var info:HistoryCourseModel? {
        didSet {
            AppPrint("info:\(String(describing: info))")
            setupAVPlayerViewController()
        }
    }
    
    /// 设置数据源
    func setupAVPlayerViewController() {
        if let strongInfo = info {
            titleLabel.stringValue = strongInfo.courseName
            nameLabel.stringValue = strongInfo.nickName
            avatarImageView.sd_setImage(with: URL(string: strongInfo.avatarUrl),
                             placeholderImage: NSImage(named: "Default_UserAvatar"))
            let videoUrl = strongInfo.videoUrl.first?.videoUrl ?? ""
            if let url = URL(string: videoUrl) {
                //let playerItem = AVPlayerItem(url: url)
                playerView.player = AVPlayer(url: url)
                playerView.player?.play()
            }
            
            for i in 0..<strongInfo.videoUrl.count {
                let model = strongInfo.videoUrl[i]
                let isSelected = (i == 0 ? true : false)
                datalist.append(VideoNumberModel(title: model.title,
                                                 isSelected: isSelected,
                                                 videoUrl: model.videoUrl))
            }
            self.collectionView.reloadData()
        }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        view.addSubview(rightContainerView)
        rightContainerView.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.width.equalTo(180)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        // 标题
        rightContainerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.height.equalTo(60)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        // 头像
        rightContainerView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.size.equalTo(CGSize(width: 80, height: 100))
            make.left.equalTo(10)
        }
        // "授课"
        let tempLabel = NSTextField(wrappingLabelWithString: "授课")
        tempLabel.alignment = .left
        tempLabel.isSelectable = false
        tempLabel.font = NSFont.systemFont(ofSize: 14)
        view.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView).offset(10)
            make.left.equalTo(avatarImageView.snp.right).offset(5)
            make.right.equalTo(-5)
            make.height.equalTo(18)
        }
        
        // 名字
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(3)
            make.left.equalTo(tempLabel)
            make.right.equalTo(tempLabel)
            make.height.equalTo(18)
        }
        
        // 剧集列表
        rightContainerView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(rightContainerView.snp.left)
        }
    }
    
    func windowWillEnterFullScreen(_ notification: Notification) {
        AppPrint("将要进入全屏")
        rightContainerView.snp.updateConstraints { make in
            make.width.equalTo(0)
        }
    }
    func windowDidEnterFullScreen(_ notification: Notification) {
        AppPrint("已经进入全屏")
    }
    func windowWillExitFullScreen(_ notification: Notification) {
        AppPrint("将要退出全屏")
        rightContainerView.snp.updateConstraints { make in
            make.width.equalTo(180)
        }
    }
    func windowDidExitFullScreen(_ notification: Notification) {
        AppPrint("已经退出全屏")
    }
}


extension VideoViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.deselectItems(at: indexPaths)
        if let indexPath = indexPaths.first {
            
            let model = datalist[indexPath.item]
            if model.isSelected == false {
                for i in 0..<datalist.count {
                    let data = datalist[i]
                    if i == indexPath.item {
                        data.isSelected = true
                    }
                    else {
                        data.isSelected = false
                    }
                }
                self.collectionView.reloadData()
                
                if let url = URL(string: model.videoUrl) {
                    playerView.player?.pause()
                    //控制器推出的模式
                    let player = AVPlayer(url: url)
                    playerView.player = player
                    playerView.player?.play()
                }
            }
        }
    }
}
extension VideoViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return datalist.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItem(
            withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "VideoNumberItem"),
            for: indexPath
        ) as! VideoNumberItem
        cell.model = datalist[indexPath.item]
        return cell
    }
}
extension VideoViewController: NSCollectionViewDelegateFlowLayout {
    
    /// 设置cell的大小
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 50, height: 25)
    }
    /// 间隔
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAt section: Int) -> NSEdgeInsets {
        return NSEdgeInsets(top: 10, left: 10, bottom: 10, right:10)
    }
    /// 行与行之间的间隔
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    /// item之间的间隔(默认是10)
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
