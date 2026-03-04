//
//  FormData.Parse.URLEncodedPairs.swift
//  swift-rfc-2388
//
//  URL-encoded form data: key=value&key=value
//

public import Parser_Primitives

extension FormData.Parse {
    /// Parses URL-encoded form data pairs.
    ///
    /// `pairs = pair *("&" pair)`
    /// `pair  = key "=" value`
    ///
    /// Keys and values are raw byte slices; percent-decoding is left
    /// to the caller.
    public struct URLEncodedPairs<Input: Collection.Slice.`Protocol`>: Sendable
    where Input: Sendable, Input.Element == UInt8 {
        @inlinable
        public init() {}
    }
}

extension FormData.Parse.URLEncodedPairs {
    public struct Pair: Sendable {
        public let key: Input
        public let value: Input

        @inlinable
        public init(key: Input, value: Input) {
            self.key = key
            self.value = value
        }
    }

    public typealias Output = [Pair]
}

extension FormData.Parse.URLEncodedPairs: Parser.`Protocol` {
    public typealias ParseOutput = Output
    public typealias Failure = Never

    @inlinable
    public func parse(_ input: inout Input) -> Output {
        var pairs: [Pair] = []

        while input.startIndex < input.endIndex {
            // Consume key (up to '=' or '&' or end)
            var keyEnd = input.startIndex
            while keyEnd < input.endIndex
                && input[keyEnd] != 0x3D  // =
                && input[keyEnd] != 0x26  // &
            {
                input.formIndex(after: &keyEnd)
            }

            let key = input[input.startIndex..<keyEnd]

            // If we hit '=', consume value
            if keyEnd < input.endIndex && input[keyEnd] == 0x3D {
                input.formIndex(after: &keyEnd)
                let valueStart = keyEnd
                while keyEnd < input.endIndex && input[keyEnd] != 0x26 {
                    input.formIndex(after: &keyEnd)
                }
                let value = input[valueStart..<keyEnd]
                pairs.append(Pair(key: key, value: value))
            } else {
                // Key with no value
                let emptyValue = input[keyEnd..<keyEnd]
                if key.startIndex < key.endIndex {
                    pairs.append(Pair(key: key, value: emptyValue))
                }
            }

            // Skip '&' separator
            if keyEnd < input.endIndex && input[keyEnd] == 0x26 {
                input.formIndex(after: &keyEnd)
            }
            input = input[keyEnd...]
        }

        return pairs
    }
}
