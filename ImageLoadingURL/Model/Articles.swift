//
//  Articles.swift
//
//  Created by linto jacob on 13/07/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Articles: Codable {

  enum CodingKeys: String, CodingKey {
    case publishedAt
    case content
    case title
    case url
    case source
    case urlToImage
    case descriptionValue = "description"
    case author
  }

  var publishedAt: String?
  var content: String?
  var title: String?
  var url: String?
  var source: Source?
  var urlToImage: String?
  var descriptionValue: String?
  var author: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
    content = try container.decodeIfPresent(String.self, forKey: .content)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    url = try container.decodeIfPresent(String.self, forKey: .url)
    source = try container.decodeIfPresent(Source.self, forKey: .source)
    urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
    descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
    author = try container.decodeIfPresent(String.self, forKey: .author)
  }

}
