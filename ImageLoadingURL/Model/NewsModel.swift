//
//  NewsModel.swift
//
//  Created by linto jacob on 13/07/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct NewsModel: Codable {

  enum CodingKeys: String, CodingKey {
    case status
    case articles
    case totalResults
  }

  var status: String?
  var articles: [Articles]?
  var totalResults: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    articles = try container.decodeIfPresent([Articles].self, forKey: .articles)
    totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
  }

}
