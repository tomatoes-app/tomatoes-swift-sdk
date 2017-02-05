//
//  Project.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public typealias ProjectBlock = (_ result: Result<Project>) -> Void
public typealias ProjectsBlock = (_ result: Result<PaginatedList<Project>>) -> Void

public class Project: Deserializable, Serializable {
    public private(set) var id: String?
    public var name: String?
    public private(set) var tags: [String]?
    public var tagList: String?
    public var moneyBudget: Int?
    public var timeBudget: Int?
    public private(set) var createdAt: Date?
    public private(set) var updatedAt: Date?
 
    required public init?(json: [String : Any]?) {
        id = json?["id"] as? String
        name = json?["name"] as? String
        tags = json?["tags"] as? [String]
        moneyBudget = json?["money_budget"] as? Int
        timeBudget = json?["time_budget"] as? Int
        let created = json?["created_at"] as? String
        createdAt = Date.date(from: created, format: Tomatoes.dateFormat)
        let updated = json?["updated_at"] as? String
        updatedAt = Date.date(from: updated, format: Tomatoes.dateFormat)
    }
    
    public init() {}
    
    public func parameters() -> [String : Any] {
        var params = [String: Any]()
        params["name"] = name
        params["tag_list"] = tagList
        params["money_budget"] = moneyBudget
        params["time_budget"] = timeBudget
        return params
    }
    
    class func responseBlock(_ completion: ProjectBlock?) -> ResponseBlock {
        return { (result, error) in
            if let project = Project(json: result) {
                completion?(.success(project))
            } else {
                completion?(.failure(error))
            }
        }
    }

    public func create(completion: ProjectBlock?) {
        let params = ["project": parameters()]
        Tomatoes.createProject.request(params, completion: Project.responseBlock(completion))
    }
    
    public class func read(id: String, completion: ProjectBlock?) {
        Tomatoes.readProject(id: id).request(completion: Project.responseBlock(completion))
    }
    
    public func update(completion: ProjectBlock?) {
        guard let id = id else {
            completion?(.failure(TomatoesError.model("Project id not found.")))
            return
        }
        let params = ["project": parameters()]
        Tomatoes.updateProject(id: id).request(params, completion: Project.responseBlock(completion))
    }
    
    public func destroy(completion: SuccessBlock?) {
        guard let id = id else {
            completion?(.failure(TomatoesError.model("Project id not found.")))
            return
        }
        Tomatoes.destroyProject(id: id).request(self.parameters()) { (_, error) in
            if let error = error {
                completion?(.failure(error))
            } else {
                completion?(.success(true))
            }
        }
    }
    
    public class func items(page: UInt, completion: ProjectsBlock?) {
        Tomatoes.readProjects(page: page).request { (result, error) in
            if let projectsList =  PaginatedList<Project>.init(json: result, root: "projects") {
                completion?(.success(projectsList))
            } else {
                completion?(.failure(error))
            }
        }
    }
}
