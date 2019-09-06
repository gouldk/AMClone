//
//  EpisodeEndpoint.swift
//  videoPlayer
//
//  Created by Kyle Gould on 9/3/19.
//  Copyright © 2019 Kyle Gould. All rights reserved.
//

import UIKit

class EpisodeEndpoint: Decodable {
    
    let success: Bool
    let status: Int
    let data: EpisodeData?
    let applied_restrictions: [String?]
}

class EpisodeData: Decodable {
    
    let posts: [EpisodePost]
    let request: EpisodeRequest
    let response: EpisodeResponse
}

class EpisodePost: Decodable {
    let id: Int
    let post_type: String
    let labels: Layout
    let images: EpisodeImage
    let meta: EpisodeMeta
}

class EpisodeMeta: Decodable {
    let amcn_field_has_drm: Bool
    let amcn_field_network: String
    let amcn_field_permalink_full: String
    let amcn_field_permalink_relative: String
    let amcn_field_playback_states_windows_end: String
    let amcn_field_playback_states_windows_start: String
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
    let amcn_field_release_pid: String
    let amcn_field_restricted_fields: String?
    let amcn_field_restricted_post: [String]
    let amcn_field_updated: String
    let amcn_field_video_category: String
    let amcn_field_video_downloadable: String?
    let amcn_field_video_end_credits_end: String?
    let amcn_field_video_end_credits_start: String?
    let amcn_field_video_end_date: String
    let amcn_field_video_id: String
    let amcn_field_video_intro_end: String?
    let amcn_field_video_intro_start: String?
    let amcn_field_video_next_on_end: String?
    let amcn_field_video_next_on_start: String?
    let amcn_field_video_opening_titles_end: String?
    let amcn_field_video_opening_titles_start: String?
    let amcn_field_video_pid: String
    let amcn_field_video_premiere_date: String
    let amcn_field_video_restricted_ads: String?
    let amcn_field_video_restricted_publish: String?
    let amcn_field_video_runtime: String?
    let amcn_field_video_tv_content_rating: String
    let amcn_field_video_type: String
    
}



class EpisodeImage: Decodable {
    let wide: WideImage
}

//class EpisodeWide: Decodable {
//    let one: ImageInfo
//    let two: ImageInfo
//    let three: ImageInfo
//
//    private enum CodingKeys : String, CodingKey { case one = "1280x720", two = "800x450", three = "427x240"}
//}

class EpisodeRequest: Decodable {
    let type: String
    let params: EpisodeParams
    let time: Int
}

class EpisodeParams: Decodable {
    let show: String
    let season: String
    let episode: String
}


class EpisodeResponse: Decodable {
    let total: Int
}
