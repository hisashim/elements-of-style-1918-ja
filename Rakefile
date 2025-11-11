require "rake/clean"

YA_MULTILINGUAL_MARKDOWN = "ya_multilingual_markdown --template-file=html.erb"
LANGS = ["en", "ja", "en,ja"]
htmls = {}

Dir.glob("*.md").reject { |f| f == "index.md" }.each { |md|
  LANGS.each { |lang|
    stem = [File.basename(md, ".md"), lang.gsub(/,/, "_")].reject(&:empty?).join("_")
    html = "#{stem}.html"

    htmls[lang] ||= []
    htmls[lang] << html

    file html => md do |t|
      options =
        if lang.nil? || lang.empty?
          ""
        else
          "--langs=#{lang} --link-suffixes='.md:_#{lang.gsub(/,/, "_")}.html'"
        end
      sh "#{YA_MULTILINGUAL_MARKDOWN} #{options} #{t.source} > #{t.name}"
    end
  }
}

file "index.html" => "index.md" do |t|
  sh "#{YA_MULTILINGUAL_MARKDOWN} #{t.source} > #{t.name}"
end

CLEAN.include(htmls.values.flatten + ["index.html"])

desc "Generate English-only files"
task :en       => htmls["en"]
desc "Generate Japanese-only files"
task :ja       => htmls["ja"]
desc "Generate files containing both English and Japanese"
task :en_ja    => htmls["en,ja"]
desc "Shorthand to generate all files"
task :all      => htmls.values.flatten + ["index.html"]

task :default => :all
