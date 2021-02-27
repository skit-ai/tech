module Author
  class AuthorPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      site.data["authors"].each do |author|
        site.pages << AuthorPage.new(site, author[0], author[1])
      end
    end
  end

  class AuthorPage < Jekyll::Page
    def initialize(site, author_alias, author_info)
      @site = site
      @base = site.source
      @dir = "authors"
      @name = author_alias + ".html"

      self.process(@name)
      template = "author-page"
      @path = @site.layouts[template].path.dup

      @data = @site.layouts[template].data
      @content = @site.layouts[template].content

      @data["author"] = {
        "alias" => author_alias,
        "info" => author_info,
        "posts" => site.posts.docs.select { |p| p.data["authors"].include? author_alias }
      }
    end
  end
end
