/**
 * Copyright IBM Corporation 2015
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

import KituraTemplateEngine
#if !os(Linux) || swift(>=3.1)
import Mustache
#endif

public class MustacheTemplateEngine: TemplateEngine {
    public var fileExtension: String { return "mustache" }
    public init() {}

    public func render(filePath: String, context: [String: Any]) throws -> String {
        #if os(Linux) && !swift(>=3.1)
            return "GRMustache is not supported on Linux with swift version less than 3.1.\n" +
                     "Please update your swift to version greater or equal than 3.1"
        #else
        let template = try Template(path: filePath)
        return try template.render(with: Box(context))
        #endif
    }
}
