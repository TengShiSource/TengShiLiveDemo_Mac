//
//  AvatarListViewController.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/23.
//

import Cocoa

@objc protocol AvatarListViewControllerDelegate : NSObjectProtocol {
    ///
    @objc func avatarListDidSelected(imageURL:String)
}

class AvatarListViewController: BaseViewController {
    
    weak var delegate:AvatarListViewControllerDelegate?
    
    var datalist:[String] = []
    
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
        collectionView.register(AvatarListItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier.init(rawValue: "AvatarListItem"))
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        requestData()
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
    
    func requestData() {
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String:String] = [:]
        manager.GETRequest(URLString: INTERFACE_getAvatarUrlList,
                           parameters: &parameters,
                           token: APPSingleton.shared.QMToken,
                           success: {requestData in
                            AppPrint(JSONSerialization.JSONString(object: requestData))
                            let code: Int? = requestData["code"] as? Int
                            if StatusCode.succeed(code: code){
                                //
                                if let data:[String] = requestData["data"] as? [String]{
                                    self.datalist = data
                                    self.collectionView.reloadData()
                                }
                                else {
                                    //                                    HUDManager.showHUDWithError(content: "空数据")
                                }
                            }
                            else{
                                //                                HUDManager.showHUDWithError(content: requestData["msg"] as? String ?? "code:\(String(describing: code))")
                            }
                           },
                           failure: { error in
                            //                            HUDManager.showHUDWithError(content: error.debugDescription)
                           })
    }
}

extension AvatarListViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.deselectItems(at: indexPaths)
        if let indexPath = indexPaths.first {
            let model = datalist[indexPath.item]
            self.delegate?.avatarListDidSelected(imageURL: model)
            self.backUpPage()
        }
    }
}
extension AvatarListViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return datalist.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let cell = collectionView.makeItem(
            withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "AvatarListItem"),
            for: indexPath
        ) as! AvatarListItem
        cell.imageUrl = datalist[indexPath.item]
        return cell
    }
}
extension AvatarListViewController: NSCollectionViewDelegateFlowLayout {
    
    /// 设置cell的大小
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        let w = (collectionView.frame.width-20)/4.0
        return NSSize(width: w, height: w)
    }
    /// 间隔
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAt section: Int) -> NSEdgeInsets {
        return NSEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    /// 行与行之间的间隔
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    /// item之间的间隔(默认是10)
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //    /// Section头部视图大小
    //    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
    //
    //    }
    //    /// Section尾部视图大小
    //    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForFooterInSection section: Int) -> NSSize {
    //
    //    }
}
