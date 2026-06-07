//
//  PhotoStorage.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 29/05/26.
//

import UIKit

enum PhotoStorage {

    static func saveProofImage(_ image: UIImage, for missionId: UUID) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let fileName = "\(missionId.uuidString).jpg"
        let url = documentsDirectory.appendingPathComponent(fileName)
        do {
            try data.write(to: url)
            return fileName
        } catch {
            return nil
        }
    }

    static func saveProfileImage(_ image: UIImage, for accountId: UUID) -> String? {
        guard let data = cropToSquare(image)?.jpegData(compressionQuality: 0.8) else { return nil }
        let fileName = "profile_\(accountId.uuidString).jpg"
        let url = documentsDirectory.appendingPathComponent(fileName)
        do {
            try data.write(to: url)
            return fileName
        } catch {
            return nil
        }
    }

    static func loadProofImage(named fileName: String) -> UIImage? {
        let url = documentsDirectory.appendingPathComponent(fileName)
        return UIImage(contentsOfFile: url.path)
    }

    static func loadProfileImage(named fileName: String) -> UIImage? {
        let url = documentsDirectory.appendingPathComponent(fileName)
        return UIImage(contentsOfFile: url.path)
    }

    private static func cropToSquare(_ image: UIImage) -> UIImage? {
        let side = min(image.size.width, image.size.height)
        let origin = CGPoint(
            x: (image.size.width - side) / 2,
            y: (image.size.height - side) / 2
        )
        let cropRect = CGRect(origin: origin, size: CGSize(width: side, height: side))
        guard let cgImage = image.cgImage?.cropping(to: cropRect) else { return nil }
        return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }

    private static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
