@_exported import HTML_Form_Coder
@_exported import HTML_Form_Coder_Nested
public import typealias HTML_Standard.HTML

/// Compatibility spelling for the nested form-data model now owned by
/// `swift-html-form-coder`.
@available(*, deprecated, renamed: "HTML.Form.Coder.Nested.Data")
public typealias FormData = HTML.Form.Coder.Nested.Data

extension HTML.Form.Coder.Nested.Data {
    @available(*, deprecated, renamed: "HTML.Form.Coder.Strategy.Nesting")
    public typealias EncodingStrategy = HTML.Form.Coder.Strategy.Nesting

    @available(*, deprecated, renamed: "HTML.Form.Coder.Strategy.Nesting")
    public typealias ParsingStrategy = HTML.Form.Coder.Strategy.Nesting
}
