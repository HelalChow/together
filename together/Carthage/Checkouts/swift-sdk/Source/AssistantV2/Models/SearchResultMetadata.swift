/**
 * Copyright IBM Corporation 2019
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/**
 An object containing search result metadata from the Discovery service.
 */
public struct SearchResultMetadata: Codable, Equatable {

    /**
     The confidence score for the given result. For more information about how the confidence is calculated, see the
     Discovery service [documentation](../discovery#query-your-collection).
     */
    public var confidence: Double?

    /**
     An unbounded measure of the relevance of a particular result, dependent on the query and matching document. A
     higher score indicates a greater match to the query parameters.
     */
    public var score: Double?

    // Map each property name to the key that shall be used for encoding/decoding.
    private enum CodingKeys: String, CodingKey {
        case confidence = "confidence"
        case score = "score"
    }

}
