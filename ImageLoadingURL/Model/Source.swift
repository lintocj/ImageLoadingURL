//
//  Source.swift
//
//  Created by linto jacob on 13/07/22
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Source: Codable {

  enum CodingKeys: String, CodingKey {
    case name
    case id
  }

  var name: String?
  var id: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    id = try container.decodeIfPresent(String.self, forKey: .id)
  }

}
