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
#if os(OSX)
import Mustache
#endif

public class KituraMustacheTemplateEngine: TemplateEngine {
    public var fileExtension: String? { return "mustache" }
    public init() {}

    public func render(filePath: String, context: [String: Any]) throws -> String {
        #if os(Linux)
            return "support for GRMustache not yet implemented on Linux"
        #else
        let template = try Template(path: filePath)
        // currently use type conversion to [String: AnyObject], works only in OS X
        let contextBox = Box(context as! [String: AnyObject])
        return try template.render(contextBox)
        #endif
    }
}
