//
//  SearchViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/02.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation

class SearchViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var resultCollectionView: UICollectionView!
  
  var movies: [Movie] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let button = UIButton()
    
    button.setPreferredSymbolConfiguration(.init(pointSize: 20), forImageIn: .normal)
  }
  
}

extension SearchViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
      return UICollectionViewCell()
    }
    
    // imagePath(String) -> UIImage
    // 3rd party 가져다 쓰기
    
    cell.movieThumbnail.kf.setImage(with: URL(string: movies[indexPath.item].thumbnailPath))
    
    return cell
  }
  
}

extension SearchViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let movie = movies[indexPath.item]
    let url = URL(string: movie.previewURL)!
    let item = AVPlayerItem(url: url)
    
    let sb = UIStoryboard(name: "Player", bundle: nil)
    let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
    vc.modalPresentationStyle = .overFullScreen
    
    vc.player.replaceCurrentItem(with: item)
    
    present(vc, animated: false, completion: nil)
  }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let margin: CGFloat = 8
    let itemSpacing: CGFloat = 10
    let width = (collectionView.bounds.width - margin * 2 - itemSpacing * 2) / 3
    let height = width * (10/7)
    return CGSize(width: width, height: height)
  }
}

class ResultCell: UICollectionViewCell {
  @IBOutlet weak var movieThumbnail: UIImageView!
}

extension SearchViewController: UISearchBarDelegate {
  
  private func dismissKeyboard() {
    searchBar.resignFirstResponder()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // 1. 키보드가 올라와 있을떄 내려가게 처리
    dismissKeyboard()
    // 2. 검색어가 있는지
    guard let searchTerm = searchBar.text,
          searchTerm.isEmpty == false else { return }
    
    // 3. 네트워킹을 통한 검색
    // - 서치펌을 가지고 네트워킹을 통해서 영화 검색
    // - 검색 API가 필요
    // - 검색에 대한 결과를 받아올 모델이 필요
    
    SearchAPI.search(searchTerm) { movies in
      // collectionView로 표현하기
      print(movies)
      self.movies = movies
      DispatchQueue.main.async {
        self.resultCollectionView.reloadData()
      }
    }
    print("--> 검색어: \(searchBar)")
  }
}

class SearchAPI {
  static func search(_ term: String, completion: @escaping ([Movie]) -> Void) {
    let session = URLSession(configuration: .default)
    
    var urlComponnents = URLComponents(string: "https://itunes.apple.com/search?")!
    let mediaQuery = URLQueryItem(name: "media", value: "movie")
    let entityQuery = URLQueryItem(name: "entity", value: "movie")
    let termQuery = URLQueryItem(name: "term", value: term)
    urlComponnents.queryItems?.append(mediaQuery)
    urlComponnents.queryItems?.append(entityQuery)
    urlComponnents.queryItems?.append(termQuery)
    let requestURL = urlComponnents.url!
    let dataTask = session.dataTask(with: requestURL) { data, response, error in
      let successRange = 200..<300
      
      guard error == nil,
            let statusCode = (response as? HTTPURLResponse)?.statusCode,
            successRange.contains(statusCode) else {
        completion([])
        return
      }
      
      guard let resultData = data else {
        completion([])
        return
      }
      
      // Data -> [Movie]
      let movies = SearchAPI.parseMovies(resultData)
      completion(movies)
    }
    
    dataTask.resume()
  }
  
  static func parseMovies(_ data: Data) -> [Movie] {
    let decoder = JSONDecoder()
    
    do {
      let response = try decoder.decode(Response.self, from: data)
      let movies = response.movies
      return movies
    } catch let error {
      print("--> parsing error: \(error.localizedDescription)")
      return []
    }
    
  }
}

struct Response: Codable {
  let resultCount: Int
  let movies: [Movie]
  
  enum CodingKeys: String, CodingKey {
    case resultCount
    case movies = "results"
  }
}

struct Movie: Codable {
  let title: String
  let director: String
  let thumbnailPath: String
  let previewURL: String
  
  enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case director = "artistName"
    case thumbnailPath = "artworkUrl100"
    case previewURL = "previewUrl"
  }
}
