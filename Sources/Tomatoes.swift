//
//  Tomatoes.swift
//  Tomatoes
//
//  Created by Giorgia Marenda on 1/22/17.
//  Copyright © 2017 Giorgia Marenda. All rights reserved.
//

import Foundation

/**
 Wrapper around the tomato.es web API. 
 http://www.tomato.es/pages/api_reference
 */
enum Tomatoes {
    
    static let baseURLString = "http://www.tomato.es"
    static let tokenKey = "tomatoes_token"
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    /// Creates a new session using a third party auth provider token.
    /// If a user associated to the access token doesn't exist, a new user will be created.
    /// The response includes a Tomatoes API token that should be used to perform authenticated requests.
    case createSession
    /// Deletes all Tomatoes API active sessions for the current user.
    case destroySession
    
    // user
    /// The request returns the current user's object of type User
    case readUser
    /// Updates current user's attributes. The request returns the updated user's object of type User.
    case updateUser
    
    // tomatoes
    /// The request returns an object of type PaginatedList with a list of tomatoes ordered by descending creation date. Each page contains 25 records, by default the first page is retuned, use the page parameter to get any other page in the range [1, totalPages].
    case readTomatoes(page: UInt)
    /// The request creates a new tomato of type Tomato.
    case createTomato
    /// The request returns a tomato of type Tomato.
    case readTomato(id: String)
    /// The request returns the updated tomato of type Tomato.
    case updateTomato(id: String)
    /// The request deletes  one of user's tomato.
    case destroyTomato(id: String)
    
    // projects
    /// The request returns an object of type PaginatedList with a list of projects ordered by descending creation date. Each page contains 25 records, by default the first page is retuned, use the page parameter to get any other page in the range [1, totalPages].
    case readProjects(page: UInt)
    /// The request creates a new project of type Project.
    case createProject
    /// The request returns one of user's projects of type Project.
    case readProject(id: String)
    /// The request returns the updated project of type Project.
    case updateProject(id: String)
    /// The request deletes one of user's projects.
    case destroyProject(id: String)
    
    // leaderboard
    /// The request returns an object of type PaginatedList with the users leaderboard for the selected period (Array of Score). The period segment could be daily, weekly, monthly, and overall. The list of leaderboard items is ordered by descending score and it's paginated. Each page contains 25 records, by default the first page is retuned, use the page parameter to get any other page in the range [1, totalPages].
    case readLeaderboard(period: Period, page: UInt)
    
    var path: String {
        switch self {
        case .createSession, .destroySession: return "/api/session"
        case .readUser, .updateUser: return "/api/user"
        case .readTomatoes, .createTomato: return "/api/tomatoes"
        case .readTomato(let id): return "/api/tomatoes/\(id)"
        case .updateTomato(let id): return "/api/tomatoes/\(id)"
        case .destroyTomato(let id): return "/api/tomatoes/\(id)"
        case .readProjects, .createProject: return "/api/projects"
        case .readProject(let id): return "/api/projects/\(id)"
        case .updateProject(let id): return "/api/projects/\(id)"
        case .destroyProject(let id): return "/api/projects/\(id)"
        case .readLeaderboard(let period, _): return "/api/leaderboard/\(period.rawValue)"
        }
    }
    
    var stubFileName: String {
        switch self {
        case .readTomatoes: return "readTomatoes.json"
        case .readProjects: return "readProjects.json"
        case .readTomato: return "readTomato.json"
        case .updateTomato: return "updateTomato.json"
        case .readProject: return "readProject.json"
        case .updateProject: return "updateProject.json"
        case .readLeaderboard: return "readLeaderboard.json"
        default: return "\(self).json"
        }
    }
    
    var method: String {
        switch self {
        case .readUser, .readTomatoes, .readTomato, .readProjects, .readProject, .readLeaderboard: return "GET"
        case .createSession, .createTomato, .createProject: return "POST"
        case .updateUser, .updateTomato, .updateProject: return "PUT"
        case .destroySession, .destroyTomato, .destroyProject: return "DELETE"
        }
    }

    func request(_ parameters: JSONObject? = nil, completion: ResponseBlock?) {
        guard let URL = URL(string: Tomatoes.baseURLString) else { return }
        let token = KeychainSwift().get(Tomatoes.tokenKey) ?? ""
        let url = URL.appendingPathComponent(path)
        
        Network.perfomRequest(url, accessToken: token, parameters: parameters, method: method) { (object, error) in
            guard let object = object else {
                completion?(nil, error)
                return
            }
            completion?(object, error)
        }
    }
}

