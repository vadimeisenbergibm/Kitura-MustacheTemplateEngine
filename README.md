<p align="center">
    <a href="http://kitura.dev/">
    <img src="https://raw.githubusercontent.com/Kitura/Kitura/master/Sources/Kitura/resources/kitura-bird.svg?sanitize=true" height="100" alt="Kitura">
    </a>
</p>

<p align="center">
    <a href="https://kitura.github.io/Kitura-MustacheTemplateEngine/index.html">
    <img src="https://img.shields.io/badge/apidoc-KituraMustacheTemplateEngine-1FBCE4.svg?style=flat" alt="APIDoc">
    </a>
    <a href="https://travis-ci.org/Kitura/Kitura-MustacheTemplateEngine">
    <img src="https://travis-ci.org/Kitura/Kitura-MustacheTemplateEngine.svg?branch=master" alt="Build Status - Master">
    </a>
    <img src="https://img.shields.io/badge/os-macOS-green.svg?style=flat" alt="macOS">
    <img src="https://img.shields.io/badge/os-linux-green.svg?style=flat" alt="Linux">
    <img src="https://img.shields.io/badge/license-Apache2-blue.svg?style=flat" alt="Apache 2">
    <a href="http://swift-at-ibm-slack.mybluemix.net/">
    <img src="http://swift-at-ibm-slack.mybluemix.net/badge.svg" alt="Slack Status">
    </a>
</p>

# Kitura-MustacheTemplateEngine
A templating engine for Kitura that uses Mustache-based templates.

Kitura-MustacheTemplateEngine is a plugin for [Kitura Template Engine](https://github.com/Kitura/Kitura-TemplateEngine.git) for using [GRMustache](https://github.com/IBM-Swift-Sunset/GRMustache.swift) with the [Kitura](https://github.com/Kitura/Kitura) server framework. This makes it easy to use Mustache templating, with a Kitura server, to create an HTML page with integrated Swift variables.

## Mustache Template File
The template file is basically HTML with gaps where we can insert code and variables. [GRMustache](https://github.com/IBM-Swift-Sunset/GRMustache.swift) is a templating language used to write a template file and Kitura-MustacheTemplateEngine can use any standard Mustache template.

[Mustache manual](https://mustache.github.io/mustache.5.html) provides documentation and examples on how to write a Mustache template File.

By default the Kitura Router will look in the `Views` folder for Mustache template files with the extension `.mustache`.

## Usage

#### Add dependencies

Add the `Kitura-MustacheTemplateEngine` package to the dependencies within your application’s `Package.swift` file. Substitute `"x.x.x"` with the latest `Kitura-MustacheTemplateEngine` [release](https://github.com/Kitura/Kitura-MustacheTemplateEngine/releases).

```swift
.package(url: "https://github.com/Kitura/Kitura-MustacheTemplateEngine.git", from: "x.x.x")
```

Add `KituraMustache` to your target's dependencies:

```swift
.target(name: "example", dependencies: ["KituraMustache"]),
```

#### Import package

```swift
import KituraMustache
```


## Example
The following example takes a server generated using `kitura init` and modifies it to serve Mustache-formatted text from a `.mustache` file.

The files which will be edited in this example, are as follows:

<pre>
&lt;ServerRepositoryName&gt;
├── Package.swift
├── Sources
│    └── Application
│         └── Application.swift
└── Views
    └── Example.mustache
</pre>

The `Views` folder and `Example.mustache` file will be created later on in this example, since they are not initialized by `kitura init`.

#### Dependencies

Add the dependencies to your `Package.swift` file (as defined in [Add dependencies](#add_dependencies) above).

#### Application.swift
Inside the `Application.swift` file, add the following code to render the `Example.mustache` template file on the "/winner" route:

```swift
import KituraMustache
```

Add the following code inside the `postInit()` function:

```swift
router.add(templateEngine: MustacheTemplateEngine())
router.get("/winner") { _, response, next in
    let  winnings = 10000.0
    let context: [String:Any] =
        ["name" : "Joe Bloggs", "winnings": winnings, "taxed_winnings": winnings * 0.6, "taxable" : true]
    try response.render("Example.mustache", context: context)
    response.status(.OK)
    next()
}
```

#### Example.mustache
Create the `Views` folder and put the following Mustache template code into a file called `Example.mustache`:

```
<html>
    Hello {{name}}!
    You have just won {{winnings}} dollars!
    {{#taxable}}
        Well, {{taxed_winnings}} dollars, after taxes.
    {{/taxable}}
</html>
```
This example is adapted from the [Mustache manual](https://mustache.github.io/mustache.5.html) code to congratulate the winner of a contest.

Run the application and once the server is running, go to [http://localhost:8080/winner](http://localhost:8080/winner) to view the rendered Mustache template.

## API documentation

For more information visit our [API reference](http://kitura.github.io/Kitura-MustacheTemplateEngine/).

## Community

We love to talk server-side Swift, and Kitura. Join our [Slack](http://swift-at-ibm-slack.mybluemix.net/) to meet the team!

## License
This library is licensed under Apache 2.0. Full license text is available in [LICENSE](https://github.com/Kitura/Kitura-MustacheTemplateEngine/blob/master/LICENSE.txt).
