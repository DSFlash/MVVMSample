//
//  PhotoListViewModel.swift
//  MVVMPlayground
//
//  Created by Neo on 03/10/2017.
//  Copyright © 2017 ST.Huang. All rights reserved.
//

import Foundation

class PhotoListViewModel {
    
    let apiService: APIServiceProtocol

    private var photos: [Photo] = [Photo]()
    
    private var cellViewModels: [PhotoListCellViewModel] = [PhotoListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    //new variables to navigate to desired screen and perform action
    var transferAction: Bool? {
        didSet {
            if transferAction == true {
                self.navigate?()
            }
            else {
                self.alertMessage = "No item exists."
            }
        }
    }
    
    var editPhotoAction: Bool? {
        didSet {
            if editPhotoAction == true {
                self.editPhoto?()
            }
        }
    }
    
    //New variables to navigating to desired screen
    var navigate: (()->())?
    var editPhoto: (()->())?

    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var isAllowSegue: Bool = false
    
    var selectedPhoto: Photo?

    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchPopularPhoto { [weak self] (success, photos, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.processFetchedPhoto(photos: photos)
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PhotoListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( photo: Photo ) -> PhotoListCellViewModel {

        //Wrap a description
        var descTextContainer: [String] = [String]()
        if let camera = photo.camera {
            descTextContainer.append(camera)
        }
        if let description = photo.description {
            descTextContainer.append( description )
        }
        let desc = descTextContainer.joined(separator: " - ")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return PhotoListCellViewModel( titleText: photo.name,
                                       descText: desc,
                                       imageUrl: photo.image_url,
                                       dateText: dateFormatter.string(from: photo.created_at) )
    }
    
    private func processFetchedPhoto( photos: [Photo] ) {
        self.photos = photos // Cache
        var vms = [PhotoListCellViewModel]()
        for photo in photos {
            vms.append( createCellViewModel(photo: photo) )
        }
        self.cellViewModels = vms
    }
    
}

extension PhotoListViewModel {

    func userPressed( at indexPath: IndexPath ){
        let photo = self.photos[indexPath.row]
        if photo.for_sale {
            self.isAllowSegue = true
            self.selectedPhoto = photo
        }else {
            self.isAllowSegue = false
            self.selectedPhoto = nil
            self.alertMessage = "This item is not for sale"
        }
        
    }
}

extension PhotoListViewModel {
    func barButtonPressed(){
        if self.photos.count > 0 && self.photos[0].image_url != "" {
            self.transferAction = true
        }
        else {
            self.transferAction = false
        }
    }
    
    func editPhotoButtonPressed(){
            self.editPhotoAction = true
    }
    
}

struct PhotoListCellViewModel {
    let titleText: String
    let descText: String
    let imageUrl: String
    let dateText: String
}
