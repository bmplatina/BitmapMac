//
//  FetchGameInformation.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/21.
//

import Foundation

class exampleGameInfo: Identifiable {
    var gameIndex: Int = 1
    var gameTitle: [String] = [
        "The Humanity",
        "OX"
    ]
    var gameDeveloper: [String] = [
        "입학했더니 무한 팀플과 과제가 쌓여버린 건에 대하여",
        "Team. Assertive"
    ]
    var gameImage: [String] = [
        "TheHumanity",
        "OX"
    ]
    var gameDistributor: [String] = [
        "Interactive Installation, Bitmap Production",
        "ENTER, Bitmap Production"
    ]
    var gameHeadline: [String] = [
        "오늘 밤, 나는 떠날 것이다",
        "몰입형 퍼즐 게임 \'OX\'의 세계로"
    ]
    var gameDescription: [String] = [
        "서울예술대학교 인터랙티브 인스톨레이션 출품작. 김달, 이재혁, 정소연 개발",
        "서울예술대학교 디지털아트 페스티벌 \"ENTER\" 출품작. 김달, 김선진, 유현승, 이재혁, 정소연 개발"
    ]
}
