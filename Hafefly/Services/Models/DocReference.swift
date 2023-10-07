//
//  DocReference.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/10/2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct DocReference: CodeIdentifiable {
    @DocumentID var id: String?
    var docId: String
    var createdAt: Timestamp
    var deletedAt: Timestamp?
}
