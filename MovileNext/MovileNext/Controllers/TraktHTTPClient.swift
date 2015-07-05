//
//  TraktHTTPClient.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import Alamofire
import Result
import Argo
import TraktModels

private enum Router: URLRequestConvertible {
    static let baseURLString = "https://api-v2launch.trakt.tv/"
    case Show(String)
    case Episode(String, Int, Int)
    case PopularShows()
    case Seasons(String)
    case Episodes(String, Int)
    
    // MARK: URLRequestConvertible
    var URLRequest: NSURLRequest {
        let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
        switch self {
        
        case .Show(let id):
            return ("shows/\(id)", ["extended": "images,full"], .GET)
            
        case .Episode(let id, let season, let epNumber):
            return ("shows/\(id)/seasons/\(season)/episodes/\(epNumber)", ["extended": "images,full"], .GET)
        
        case .PopularShows():
            return ("shows/popular", ["limit": "1000", "extended": "images,full"], .GET)
        
        case .Seasons(let showId):
            return ("shows/\(showId)/seasons", ["extended": "images,full"], .GET)
        
        case .Episodes(let showId, let season):
            return ("shows/\(showId)/seasons/\(season)/episodes", ["extended": "images,full"], .GET)
        
        }
        
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue
        
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(URLRequest, parameters: parameters).0
    }
}




class TraktHTTPClient {
    private lazy var manager: Alamofire.Manager = {
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["Content-Type"] = "application/json"
            headers["trakt-api-key"] = "bc3aebd75317db1fc5540284f5a4f01f04658e36f467672ea07b9b29963037f3"
            headers["trakt-api-version"] = "2"
            
            
            configuration.HTTPAdditionalHeaders = headers
            return configuration
        }()
        return Manager(configuration: configuration)
    }()
    
    private func getJSONElement<T: Decodable where T.DecodedType == T>(router: Router, completion: ((Result<T, NSError?>) -> Void)?){
        manager.request(router).validate().responseJSON {(_, _, responseObject, error) in
            if let json = responseObject as? NSDictionary{
                let decoded = T.decode(JSON.parse(json))
        
                if let value = decoded.value{
                    completion?(Result.success(value))
                }else{
                    completion?(Result.failure(nil))
                }
            }else{
                completion?(Result.failure(error))
            }
        }
    }
            
    private func getJSONElements<T: Decodable where T.DecodedType == T>(router: Router, completion: ((Result<[T], NSError?>) -> Void)?){
        manager.request(router).validate().responseJSON {(_, _, responseObject, error) in
            //println(responseObject)
            //println(error)
            if let json = responseObject as? [NSDictionary]{
                var returnValues = [T]()
                for x in json{
                    let decoded = T.decode(JSON.parse(x))
                    if let value = decoded.value{
                        //println(value)
                        returnValues.append(value)
                    }
                }
                completion?(Result.success(returnValues))
            
            }else{
                completion?(Result.failure(error))
            }
        }
    }
            
    
    func getShow(id: String, completion: ((Result<Show, NSError?>) -> Void)?) {
        let router = Router.Show(id)
        getJSONElement(router, completion: completion)
        /*
        //TODO O CODIGO ABAIXO FOI UNIFICADO NO METODO getJSONElement
        
        manager.request(Router.Show(id)).validate().responseJSON{(_,_,responseObject,err) in
            //(Result<Show, NSError?>) -> Dessa maneira ou retorna um show ou retorna um erro
            
            //println(JSON)
            //println(err)
    
            if let resultado = responseObject as? NSDictionary{
                let decoded = Show.decode(JSON.parse(resultado))
                if let value = decoded.value{
                    
                    //RETORNANDO SHOW
                    completion?(Result.success(value))
                }else{
                    
                    //RETORNANDO ERRO
                    completion?(Result.failure(nil))
                }
            }else{
                completion?(Result.failure(err))
            }

        }
        */
    }
    
    func getEpisode(showId: String, season: Int, episodeNumber: Int, completion: ((Result<Episode, NSError?>) -> Void)?){
                
        let router = Router.Episode(showId, season, episodeNumber)
        getJSONElement(router, completion: completion)
        
        /*
        //TODO O CODIGO ABAIXO FOI UNIFICADO NO METODO getJSONElement
        manager.request(Router.Episode(showId, season, episodeNumber)).validate().responseJSON{(_,_,responseObject,err) in
        //println(err)
            if let resultado = responseObject as? NSDictionary{
                let decoded = Episode.decode(JSON.parse(resultado))
                if let value = decoded.value{
                    //RETORNANDO SHOW
                    completion?(Result.success(value))
                }else{
                    //RETORNANDO ERRO
                    completion?(Result.failure(nil))
                }
            }else{
                completion?(Result.failure(err))
            }


        }
        */
    }
            
    func getPopularShows(completion: ((Result<Array<Show>, NSError?>) -> Void)?){
        let router = Router.PopularShows()
        getJSONElements(router, completion: completion)
    }
    
    func getSeasons(showId: String, completion: ((Result<Array<Season>, NSError?>) -> Void)?){
        let router = Router.Seasons(showId)
        getJSONElements(router, completion: completion)
    }
    
    func getEpisodes(showId: String, season: Int , completion: ((Result<Array<Episode>, NSError?>) -> Void)?){
        let router = Router.Episodes(showId, season)
        getJSONElements(router, completion: completion)
    }
    
    
            
            
            
}



