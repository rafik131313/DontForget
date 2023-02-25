//
//  ToDoFileManager.swift
//  DontForget
//
//  Created by Rafał on 02/03/2023.
//

import Foundation

class ToDoFileManager {
    
    static let instance = ToDoFileManager()
    
    @Published var currentToDoArray: [ToDoModel] = []
    
    let dataFolder = "ToDoData"
    
    private init(){
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded(){
        guard
            let url = getFolderPath() else {return}
        
        if !FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("Created folder!")
            } catch let error {
                print("Error while creating directory \(error)")
            }
        }
        
    }
    
    //returns path to folder with data
    func getFolderPath() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(dataFolder)
    }
    
    private func getToDoItemPath(key: String) -> URL? {
        guard
            let folder = getFolderPath() else {
            return nil
        }
        return folder.appending(path: key + ".json")
    }
    
    func addToFileManager(key: String, item: ToDoModel) {
        guard
            let data = try? JSONEncoder().encode(item),
            let url = getToDoItemPath(key: key) else {
                print("Encoding problem")
                return
        }
        do {
            try data.write(to: url)
            print("Saved data to FM")
            currentToDoArray.append(item)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updateCurrentToDoModelItemList(model: ToDoModel){

        guard
            let data = try? JSONEncoder().encode(model),
            let url = getToDoItemPath(key: model.name) else { return }

        do {
            try data.write(to: url)
            print("Current Model has been updated \(model.name)")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func deleteFromFileManager(at offsets: IndexSet){
        
        let fileManager = FileManager.default
        for offset in offsets {
            let item = currentToDoArray[offset]
            if let url = getToDoItemPath(key: item.name) {
                try? fileManager.removeItem(at: url)
            }
        }
    }
    
    
    func getModelFromFileManager(key: String) -> ToDoModel? {
        guard
            let url = getToDoItemPath(key: key),
            FileManager.default.fileExists(atPath: url.path) else { return nil }
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(ToDoModel.self, from: data)
            return decodedData
        } catch {
            print("Error while decoding")
        }
        return nil
    }
    
    ///Returns all data from Filemanager
    func getAllToDoItems(){
        var items = [ToDoModel]()
        
        guard let folder = getFolderPath() else {
            print("Data folder not found")
            return
        }
        
        do {
            let fileUrls = try FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil, options: [])
            for fileUrl in fileUrls {
                let data = try Data(contentsOf: fileUrl)
                let decodedData = try JSONDecoder().decode(ToDoModel.self, from: data)
                items.append(decodedData)
            }
        } catch {
            print("Error while reading files: \(error.localizedDescription)")
        }
        
        self.currentToDoArray = items
    }
    


    
}
