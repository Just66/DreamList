//
//  ItemDetailsVC.swift
//  DreamList
//
//  Created by Dmytro Aprelenko on 24.01.17.
//  Copyright © 2017 Dmytro Aprelenko. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var detailsTitle: UITextField!
    @IBOutlet weak var detailMeans: UITextField!
    @IBOutlet weak var detailsDescription: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var thumgImg: UIImageView!
    
    var stores = [Store]()
    var types = [ItemType]()
    var itemToEdit: Item?
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        picker.dataSource = self
        picker.delegate = self
        
//        let store1 = Store(context: context)
//        store1.name = "Cosmos"
//        let store2 = Store(context: context)
//        store2.name = "Timberland"
//        let store3 = Store(context: context)
//        store3.name = "Comfy"
//        let store4 = Store(context: context)
//        store4.name = "BMW"
//        let type = ItemType(context: context)
//        type.type = "Food"
//        let type1 = ItemType(context: context)
//        type1.type = "Vehicls"
//        let type2 = ItemType(context: context)
//        type2.type = "Electronics"
//        let type3 = ItemType(context: context)
//        type3.type = "Entertainment"
//        let type4 = ItemType(context: context)
//        type4.type = "Goals"
//        let type5 = ItemType(context: context)
//        type5.type = "Wear"
//        ad.saveContext()
        
        getStores()
        getItemTypes()
        mainTitle()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if component == 0 {
            return stores.count
        }
        if component == 1 {
            return types.count
        }
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // TODO: when selected
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
        let store = stores[row]
        return store.name
        }
        if component == 1 {
            let type = types[row]
            return type.type
        }
        return (nil)
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
           self.stores = try context.fetch(fetchRequest)
            self.picker.reloadAllComponents()
        } catch {
            // TODO nothing
        }
    }
    
    func getItemTypes() {
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        do {
            self.types = try context.fetch(fetchRequest)
            self.picker.reloadAllComponents()
        } catch {
            // TODO nothing
        }
    }
    
    @IBAction func saveItem(_ sender: UIButton) {
        var item: Item!
        let picture = Image(context: context)
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
       
        
        if let title = detailsTitle.text {
            item.title = title
        }
        if let means = detailMeans.text {
            item.price = (means as NSString).doubleValue
        }
        if let description = detailsDescription.text {
            item.details = description
        }
        item.toStore = stores[picker.selectedRow(inComponent: 0)]
        picture.image = thumgImg.image
        item.toImage = picture
        item.toItemType = types[picker.selectedRow(inComponent: 1)]
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }

    func loadItemData () {
        if let item = itemToEdit {
            detailsTitle.text = item.title
            detailMeans.text = ("\(item.price)")
            detailsDescription.text = item.title
            thumgImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                 var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        picker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while index < stores.count 
            }
            if let store = item.toItemType {
                var index = 0
                repeat {
                    let s = types[index]
                    if s.type == store.type {
                        picker.selectRow(index, inComponent: 1, animated: false)
                        break
                    }
                    index += 1
                } while index < types.count
            }
            
        }
    }
    
    @IBAction func deleteBut(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumgImg.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    func mainTitle() {
        if itemToEdit != nil {
            navigationItem.title = "Edit"
        } else {
            navigationItem.title = "Add"
        }
    }
}
