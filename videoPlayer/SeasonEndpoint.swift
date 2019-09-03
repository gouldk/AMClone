//
//  SeasonEndpoint.swift
//  videoPlayer
//
//  Created by Kyle Gould on 9/3/19.
//  Copyright © 2019 Kyle Gould. All rights reserved.
//

import UIKit

class SeasonEndpoint: Decodable {

    let success: Bool
    let status: Int
    let data: Data
    let applied_restrictions: [String?]
    
}

class Data: Decodable {
    let posts: [Post]
    let request: Request
    let response: Response
}

class Response: Decodable {
    let total: Int
}

class Request: Decodable {
    let type: String
    let params: Params
    let time: Int
}

class Params: Decodable {
    let show: String
    let season: String
    let sort_by: String
    let sort_order: String
}

class Post: Decodable {
    let id: Int
    let post_type: String
    let labels: Layout
    let images: Image
    let meta: Meta
}

class Meta: Decodable {
    let amcn_field_amcn_tribune_id: String?
    let amcn_field_network: String
    let amcn_field_permalink_full: String
    let amcn_field_permalink_relative: String
    let amcn_field_post_date_gmt: String
    let amcn_field_post_id: String
    let amcn_field_post_modified_gmt: String
    let amcn_field_post_name: String
    let amcn_field_post_title: String
    let amcn_field_post_type: String
    let amcn_field_relation_episode_display: String
    let amcn_field_relation_episode_id: String
    let amcn_field_relation_episode_name: String
    let amcn_field_relation_episode_number: String
    let amcn_field_relation_season_display: String
    let amcn_field_relation_season_id: String
    let amcn_field_relation_season_name: String
    let amcn_field_relation_season_number: String
    let amcn_field_relation_show_display: String
    let amcn_field_relation_show_id: String
    let amcn_field_relation_show_name: String
    let amcn_field_restricted_fields: String?
    let amcn_field_restricted_post: String?
    let amcn_field_updated: String
    let amcn_field_video_restricted_ads: String
    let amcn_field_video_type: String?
}

class Image: Decodable {
    let poster: [String] // ? figure out
    let square: SquareImage
    let wide: WideImage
    let ultrawide: UltrawideImage
}

class SquareImage: Decodable {
    var threeThousand: ImageInfo
    private enum CodingKeys : String, CodingKey { case threeThousand = "3000x3000"}
}

class WideImage: Decodable {
    let one: ImageInfo
    let two: ImageInfo
    let three: ImageInfo
    
    private enum CodingKeys : String, CodingKey { case one = "1280x720", two = "800x450", three = "427x240"}
}

class UltrawideImage: Decodable {
    let one: ImageInfo
    let two: ImageInfo
    
    private enum CodingKeys : String, CodingKey { case one = "3200x1440", two = "2400x1080"}
}

class ImageInfo: Decodable {
    let full: String
    let relative: String
    let width: Int
    let height: Int
}

class Layout: Decodable {
    let layout_video: LayoutVideo
    let layout_content_list_item: LayoutContentListItem
    let layout_content_details: LayoutContentDetails
    let layout_video_player: LayoutVideoPlayer
}

class LayoutVideo: Decodable {
    let slot_1: String
    let slot_2: String
}

class LayoutContentListItem: Decodable {
    let slot_1: String
    let slot_2: String
    let slot_3: String
    let slot_4: String
    let slot_5: String
    let slot_6: String
    let slot_7: String
}

class LayoutContentDetails: Decodable {
    let slot_1: String
    let slot_2: String
    let slot_3: String
    let slot_4: String
    let slot_5: String
    let slot_6: String
    let slot_7: String
    let slot_8: String
    let slot_9: String
}

class LayoutVideoPlayer: Decodable {
    let slot_1: String
    let slot_2: String
    let slot_3: String
    let slot_4: String
    let slot_5: String
    let slot_6: String
    let slot_7: String
    let slot_8: String
    let slot_9: String
}
