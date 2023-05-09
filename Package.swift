// swift-tools-version: 5.7.1
import PackageDescription

let package = Package(
  name: "CameLLM",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
  ],
  products: [
    .library(
      name: "CameLLM",
      targets: ["CameLLM"]),
    .library(
      name: "CameLLMObjCxx",
      targets: ["CameLLMObjCxx"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "CameLLM",
      dependencies: ["CameLLMObjCxx"]),
    .target(
      name: "CameLLMObjCxx",
      dependencies: []
    )
  ]
)
