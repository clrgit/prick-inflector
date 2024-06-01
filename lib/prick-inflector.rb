# frozen_string_literal: true

require "dry-inflector"

module Prick; end

require_relative "prick-inflector/version"

module Prick::Inflector
  class Error < StandardError; end

  def self.pluralize(word)
    return word if plural? word
    result = @@inflector.pluralize(word)
    if result == word
      word =~ /s$/ ? "#{word}es" : "#{word}s"
    else
      result
    end
  end

  # Note that DryInflector::singularize handles the special PgGraph
  # pluralization rules by default
  def self.singularize(word)
    if word == "s" # Dry::Inflector return an empty string
      "s"
    elsif word =~ /^(.*s)es$/ && pluralize($1) == word
      $1
    else
      @@inflector.singularize(word)
    end
  end

  # #plural? is defined using #singularize because #pluralize would cause
  # endless recursion
  def self.plural?(word)
    singularize(word) != word
  end

  def self.singular?(word)
    singularize(word) == word
  end

private
  @@inflector = Dry::Inflector.new
end

module String::Prick; end

module String::Prick::Inflector
  class Error < StandardError; end
  
  refine String do
    def pluralize = Prick::Inflector.pluralize(self)
    def singularize = Prick::Inflector.singularize(self)
    def plural? = Prick::Inflector.plural?(self)
    def singular? = Prick::Inflector.singular?(self)
  end
end

