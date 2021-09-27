//
//  HistoryCourseViewController.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/23.
//

import Cocoa

class HistoryCourseViewController: BaseViewController {
    
    var VideoWC:VideoWindowController?

    var userId:Int = 0
    
    var datalist:[HistoryCourseModel] = []
    
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
        collectionView.register(HistoryCourseItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier.init(rawValue: "HistoryCourseItem"))
        return collectionView
    }()
    
    lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.documentView = collectionView
        scrollView.scrollerStyle = NSScroller.Style.overlay
        scrollView.horizontalScrollElasticity = .automatic
        scrollView.verticalScrollElasticity = .automatic
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.titleLabel.stringValue = "历史课程"
        createUI()
        loadData()
    }
    
    func createUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    func loadData() {
        
        let userRole:String = "t"
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String:String] = [:]
        parameters["userId"] = String(userId)
        parameters["userRole"] = userRole
        manager.GETRequest(URLString: INTERFACE_getCourseVideoList,
                           parameters: &parameters,
                           token: APPSingleton.shared.QMToken,
                           success: {requestData in
                            AppPrint(JSONSerialization.JSONString(object: requestData))
                            let code: Int? = requestData["code"] as? Int
                            if StatusCode.succeed(code: code){
                                //
                                if let data:[[String:Any]] = requestData["data"] as? [[String:Any]]{
                                    for obj in data {
                                        let avatarUrl = obj["avatarUrl"] as? String ?? ""
                                        let courseName = obj["courseName"] as? String ?? ""
                                        let startTime = obj["startTime"] as? String ?? ""
                                        let endTime = obj["endTime"] as? String ?? ""
                                        let fileId = obj["fileId"] as? String ?? ""
                                        let nickName = obj["nickName"] as? String ?? ""
                                        var tempVideoUrl:[VideoModel] = []
                                        if let videoUrls = obj["videoInfos"] as? [[String:Any]] {
                                            var i = 1
                                            for videoUrl in videoUrls {
                                                let title = "第\(i)段"
                                                i = i + 1
                                                let url:String = videoUrl["videoUrl"] as? String ?? ""
                                                tempVideoUrl.append(VideoModel(title: title, videoUrl: url))
                                            }
                                        }
                                        let model = HistoryCourseModel(avatarUrl: avatarUrl,
                                                                       courseName: courseName,
                                                                       startTime: startTime,
                                                                       endTime: endTime,
                                                                       fileId: fileId,
                                                                       nickName: nickName,
                                                                       videoUrl: tempVideoUrl)
                                        self.datalist.append(model)
                                    }
                                    self.collectionView.reloadData()
                                }
                                else {
                                    
                                }
                            }
                            else{
                            }
                           },
                           failure: { error in
                            
                           })
    }
}

extension HistoryCourseViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.deselectItems(at: indexPaths)
        if let indexPath = indexPaths.first {
            let model = datalist[indexPath.item]

            if let VC =  VideoWC?.window?.contentViewController as? VideoViewController {
                VC.info = model
            }
            else {
                if let windowController = NSStoryboard.init(name: "Video", bundle: nil).instantiateInitialController() as? VideoWindowController {
                    windowController.delegate = self
                    VideoWC = windowController
                    windowController.window?.makeKeyAndOrderFront(nil)
                    if let VC =  windowController.window?.contentViewController as? VideoViewController {
                        VC.info = model
                    }
                }
            }
        }
    }
}

extension HistoryCourseViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return datalist.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let cell = collectionView.makeItem(
            withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HistoryCourseItem"),
            for: indexPath
        ) as! HistoryCourseItem
        cell.model = datalist[indexPath.item]
        return cell
    }
}

extension HistoryCourseViewController: NSCollectionViewDelegateFlowLayout {
    
    /// 设置cell的大小
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        let w = collectionView.frame.width
        let h:CGFloat = 150
        return NSSize(width: w, height: h)
    }
    /// 间隔
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAt section: Int) -> NSEdgeInsets {
        return NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    /// 行与行之间的间隔
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    /// item之间的间隔(默认是10)
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HistoryCourseViewController:VideoWindowControllerDelegate {
    func VideoWindowControllerDidClose() {
        VideoWC = nil
    }
}
