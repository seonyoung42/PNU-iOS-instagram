//
//  ImageUploader.swift
//  Instagram
//
//  Created by 장선영 on 2021/11/11.
//

import UIKit
import Firebase

struct ImageUploader {
    
    // uploadImage 함수 만들기 (함수 로직부터 짜기)
    // uploadImage(이미지파일, callback)
    // -> 이미지를 무조건 jpg로 변경. jpg가 안되면 종료
    // -> 이미지 이름을 난수로 변경. 중첩되면 안되기 때문
    // -> storage에 저장한다. 단, 프로필 이미지 폴더에 저장하도록 설정
    // -> storage에 파일을 전송한다.
    //    -> callback을 통해서 반환값(성공/실패)전달하도록 함
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("에러: 프로필 이미지 업로드에 실패하였습니다. \(error.localizedDescription)")
                return
            }
            
            print("성공: 프로필 이미지 업로드에 성공하였습니다.")
            ref.downloadURL { url, _ in
                guard let imageURL = url?.absoluteString else { return }
                completion(imageURL)
            }
        }
        
    }
}
