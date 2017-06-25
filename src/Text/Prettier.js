var prettier = require('prettier')

function getOptions(fromTrailingComma, fromRange, fromParser, options) {
  options = Object.assign({}, options)
  options.trailingComma = fromTrailingComma(options.trailingComma)
  options.rangeEnd = fromRange(options.rangeEnd)
  options.parser = fromParser(options.parser)
  return options
}

exports.infinity = Infinity

exports.formatImpl = function(fromTrailingComma) {
  return function(fromRange) {
    return function(fromParser) {
      return function(options) {
        return function(source) {
          return prettier.format(source, getOptions(fromTrailingComma, fromRange, fromParser, options))
        }
      }
    }
  }
}

exports.checkImpl = function(fromTrailingComma) {
  return function(fromRange) {
    return function(fromParser) {
      return function(options) {
        return function(source) {
          return prettier.check(source, getOptions(fromTrailingComma, fromRange, fromParser, options))
        }
      }
    }
  }
}

exports.formatWithCursorImpl = function(fromTrailingComma) {
  return function(fromRange) {
    return function(fromParser) {
      return function(options) {
        return function(source) {
          return prettier.formatWithCursor(source, getOptions(fromTrailingComma, fromRange, fromParser, options))
        }
      }
    }
  }
}
