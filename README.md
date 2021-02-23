# tech @ vernacular.ai

![github-pages](https://github.com/Vernacular-ai/tech/actions/workflows/github-pages.yml/badge.svg)

This is source for the [tech team webpage][tech_blog] at Vernacular.ai. Template is [Mundana by WowThemes.net][mundana]

## Developing

- Install [rbenv](https://github.com/rbenv/rbenv) and
  [ruby-build](https://github.com/rbenv/ruby-build) for managing Ruby version.
- Install ruby version for this repo. `rbenv install 2.7.2`. A local
  `.ruby-version` file will make sure the repository uses consistent ruby
  version.
- Install [bundler](https://bundler.io/) using `gem install bundler`.
- Run `bundle` for installing dependencies.
- Run the blog locally: `bundle exec jekyll serve --host=0.0.0.0`

[tech_blog]: https://tech.vernacular.ai/
[mundana]: https://github.com/wowthemesnet/mundana-theme-jekyll

