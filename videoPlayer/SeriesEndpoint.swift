import UIKit

class SeriesEndpoint: Decodable {

    let success: Bool
    let status: Int
    let data: SeriesData
    let applied_restrictions: [String?]
    
}

class SeriesData: Decodable {
    
    let posts: [SeriesPost]
    let request: SeriesRequest
    let response: SeriesResponse
    
}

class SeriesPost: Decodable {
    let id: Int
    let post_type: String
    let labels: SeriesLabel
    let images: SeriesImages
    let meta: SeriesMeta
}

class SeriesLabel: Decodable {
    let layout_hero: SeriesLayoutHero
    let layout_poster: SeriesLayoutPoster
    let layout_hero_info: SeriesLayoutHeroInfo
    let layout_hero_stack: SeriesLayoutHeroStack
    let layout_info: SeriesLayoutInfo
}

class SeriesLayoutHero: Decodable {
    let slot_1: String
    let slot_2: String
    let slot_3: String
    let slot_4: String
    let slot_5: String
    let slot_6: String
    let slot_7: String
}

class SeriesLayoutPoster: Decodable {
    let slot_1: String
    let slot_2: String
}

class SeriesLayoutHeroInfo: Decodable {
    let slot_1: String
    let slot_2: String
    let slot_3: String
}

class SeriesLayoutHeroStack: Decodable {
    let slot_1: String
    let slot_2: String
    let slot_3: String
}

class SeriesLayoutInfo: Decodable {
    let slot_1: String
    let slot_2: String
}

class SeriesImages: Decodable {
    let poster: SeriesPoster
    let wide_poster: SeriesWidePoster
    let standard: SeriesStandard
    let square: SeriesSquare
    let wide: SeriesWide
    let ultrawide: SeriesUltrawide
    let long: LongImage
}

class LongImage: Decodable {
    let one: ImageDetail
    
    private enum CodingKeys : String, CodingKey {case one = "1125x1374"}
}

class ImageDetail: Decodable {
    
    var full: String
    var relative: String
    var width: Int?
    var height: Int?
    
//    required init(from decoder: Decoder) throws {
//        let container =  try decoder.singleValueContainer()
//
//        // Check for a String
//        do {
//            width = try container.decode(Int.self)
//            height = try container.decode(Int.self)
//            full = try container.decode(String.self)
//            relative = try container.decode(String.self)
//        } catch {
//            // Check for an integer
//            width = try container.decode(String.self)
//            height = try container.decode(String.self)
//            full = try container.decode(String.self)
//            relative = try container.decode(String.self)
//        }
//    }
}

class SeriesPoster: Decodable {
    let one: ImageDetail
    
    private enum CodingKeys : String, CodingKey { case one = "200x300"}
}

class SeriesWidePoster: Decodable {
    let one: ImageDetail
    
    private enum CodingKeys : String, CodingKey {case one = "427x240"}
}

class SeriesStandard: Decodable {
    let one: ImageDetail
    
    private enum CodingKeys : String, CodingKey {case one = "800x600"}
}

class SeriesSquare: Decodable {
    let one: ImageDetail
    
    private enum CodingKeys : String, CodingKey {case one = "3000x3000"}
}

class SeriesWide: Decodable {
    let one: ImageDetail
    let two: ImageDetail
    let three: ImageDetail
    
    private enum CodingKeys : String, CodingKey { case one = "1280x720", two = "800x450", three = "427x240"}
}

class SeriesUltrawide: Decodable {
    let one: ImageDetail
    let two: ImageDetail
    
    private enum CodingKeys : String, CodingKey { case one = "3200x1440", two = "2400x1080"}
}

class SeriesMeta: Decodable {
    
    let amcn_field_amcn_tribune_id: String?
    let amcn_field_network: String?
    let amcn_field_permalink_full: String?
    let amcn_field_permalink_relative: String?
    let amcn_field_post_date_gmt: String?
    let amcn_field_post_id: String?
    let amcn_field_post_modified_gmt: String?
    let amcn_field_post_name: String?
    let amcn_field_post_title: String?
    let amcn_field_post_type: String?
    let amcn_field_relation_episode_display: String?
    let amcn_field_relation_episode_id: String?
    let amcn_field_relation_episode_name: String?
    let amcn_field_relation_episode_number: String?
    let amcn_field_relation_season_display: String?
    let amcn_field_relation_season_id: String?
    let amcn_field_relation_season_name: String?
    let amcn_field_relation_season_number: String?
    let amcn_field_relation_show_display: String?
    let amcn_field_relation_show_id: String?
    let amcn_field_relation_show_name:String?
    let amcn_field_restricted_fields: [String]?
    let amcn_field_restricted_post: [String]?
    let amcn_field_show_accent_color: String?
    let amcn_field_show_accent_hover_color: String?
    let amcn_field_show_branding: ShowBranding?
    let amcn_field_show_current_season: String?
    let amcn_field_show_menu_active_color: String?
    let amcn_field_show_menu_color: String?
    let amcn_field_show_nielsen_program_name: String?
    let amcn_field_show_nielsen_summary_type_code: String?
    let amcn_field_show_nielsen_summary_type_description: String?
    let amcn_field_show_nielson_detail_type_code: String?
    let amcn_field_show_season: Bool?
    let amcn_field_show_upsell: SeriesUpsell?
    let amcn_field_updated: String?
}

class SeriesUpsell: Decodable {
    let upsell_copy: String
    let upsell_badge: String
    let upsell_flag: String
}

class ShowBranding: Decodable {
    let logo: ImageDetail
    let background: ImageDetail
    let accent_color: String
}

class SeriesResponse: Decodable {
    let total: Int
}

class SeriesRequest: Decodable {
    let type: String
    let params: SeriesParams
    let time: Int
}

class SeriesParams: Decodable {
    let show: String
}
