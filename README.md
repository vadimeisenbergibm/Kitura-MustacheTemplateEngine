<p align="center">
<a href="http://kitura.io/">
<img src="https://raw.githubusercontent.com/IBM-Swift/Kitura/master/Sources/Kitura/resources/kitura-bird.svg?sanitize=true" height="100" alt="Kitura">
</a>
</p>


<p align="center">
<a href="http://www.kitura.io/">
<img src="https://img.shields.io/badge/docs-kitura.io-1FBCE4.svg" alt="Docs">
</a>
<a href="https://travis-ci.org/IBM-Swift/Kitura-StencilTemplateEngine">
<img src="https://travis-ci.org/IBM-Swift/Kitura-StencilTemplateEngine.svg?branch=master" alt="Build Status - Master">
</a>
<img src="https://img.shields.io/badge/os-Mac%20OS%20X-green.svg?style=flat" alt="Mac OS X">
<img src="https://img.shields.io/badge/os-linux-green.svg?style=flat" alt="Linux">
<img src="https://img.shields.io/badge/license-Apache2-blue.svg?style=flat" alt="Apache 2">
<a href="http://swift-at-ibm-slack.mybluemix.net/">
<img src="http://swift-at-ibm-slack.mybluemix.net/badge.svg" alt="Slack Status">
</a>
</p>

# Kitura-MustacheTemplateEngine
A Templating engine for Kitura that uses Mustache-based templates.

## Summary
Kitura-MustacheTemplateEngine is a plugin for [Kitura Template Engine](https://github.com/IBM-Swift/Kitura-TemplateEngine.git) for using [GRMustache](https://github.com/IBM-Swift/GRMustache.swift.git) with the [Kitura](https://github.com/IBM-Swift/Kitura) server framework. This makes it easy to use Mustache templating, with a Kitura server, to create an HTML page with integrated Swift variables.

## Mustache Template File
The template file is basically HTML with gaps where we can insert code and variables. [GRMustache](https://github.com/IBM-Swift/GRMustache.swift.git) is a templating language used to write a template file and Kitura-MustacheTemplateEngine can use any standard Mustache template.

[Mustache manual](https://mustache.github.io/mustache.5.html) provides documentation and examples on writing a Mustache Template File.

By default the Kitura Router will look in the 'Views' folder for Mustache template files with the extension '.mustache'.


## Example
The following is an example of a server generated using `Kitura init` that serves Mustache-formatted text from a `.mustache` file.

The files which have been edited in this example, are structured as follows:

<pre>
<ServerRepository>
├── Package.swift
├── Sources
│    └── Application
│         └── Application.swift
└── Views
└── Example.mustache
</pre>

The `Views` Folder and `Example.mustache` file will be created later on in this example, since they are not initialized by `Kitura init`.

### Package.swift
defined ["https://github.com/IBM-Swift/Kitura-MustacheTemplateEngine.git"](https://github.com/IBM-Swift/Kitura-MustacheTemplateEngine.git)  as a dependency.
add "KituraMustache" to the targets for Application.

### Application.swift
Inside the `Application.swift` file, add the following code to render the `Example.mustache` template file on the "/winner" route.

```swift
import KituraMustache
```

Add the following code inside the `postInit()` function:

```swift
router.add(templateEngine: MustacheTemplateEngine())
router.get("/winner") { _, response, next in
    winnings = 10000
    var context: [String:Any] =
    ["name" : "Joe Bloggs", "winnings": winnings, "taxed_winnings": winnings * 0.6, "taxable" : true]
    try response.render("Example.mustache", context: context).end()
    response.status(.OK)
    next()
}
```

### Example.mustache
Create the `Views` folder and put the following Stencil template code into a file called `Example.mustache` in this directory. This template will insert a count of the number of articles followed by a list of the articles and their authors.

```
<html>
    Hello {{name}}
    You have just won {{value}} dollars!
    {{#in_ca}}
        Well, {{taxed_value}} dollars, after taxes.
    {{/in_ca}}
</html>
```

Run the application and once the server is running, go to [http://localhost:8080/employees](http://localhost:8080/employees) to view the rendered Mustache template.

## License
This library is licensed under Apache 2.0. Full license text is available in [LICENSE](LICENSE.txt).

