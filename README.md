# tech @ Skit

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/skit-ai/tech/github-pages.yml?branch=master&style=flat-square)

This is source for the [tech team webpage][tech_blog] at Skit. Template is [Mundana by WowThemes.net][mundana]

## Developing

- Install [rbenv](https://github.com/rbenv/rbenv) and
  [ruby-build](https://github.com/rbenv/ruby-build) for managing Ruby version.
- Install ruby version for this repo. `rbenv install 2.7.2`. A local
  `.ruby-version` file will make sure the repository uses consistent ruby
  version.
- Install [bundler](https://bundler.io/) using `gem install bundler -v 2.4.22`. Note that newer versions of bundler need newer ruby so we will work with an older version for now.
- Run `bundle` for installing dependencies.
- Run the blog locally: `bundle exec jekyll serve --host=0.0.0.0`

Deployment is handled via github actions using [this workflow](./.github/workflows/github-pages.yml) which gets triggered on every push.

### LaTeX

We use [MathJax v3](https://www.mathjax.org/) to render LaTeX equations. For
enabling in your post, add `latex: True` in your yaml frontmatter. After that,
equations under `$$` (note the double dollar sign) will be rendered like below:

```
$$p_\theta(z_k) = p_\theta(z_0)* \prod_{i=1..k}|\det(\frac{\partial f_i}{\partial z_{i-1}})|^{-1}$$
```

![](./screens/latex.png)

### Fancy audio player

Instead of the default HTML audio player, you can use a fancy audio player that
looks like the following:

![Fancy Player Screenshot](./screens/fancy-player.png)

For using this, add `fancy_audio_player: True` in your post's yaml frontmatter
and use `fancy_audio` tag like below:

```
{% fancy_audio https://vai-diarization.s3.ap-south-1.amazonaws.com/1573539792.52506.003.wav %}
```

### Post Cover Image

You can provide a cover image for the post using the following yaml frontmatter:

```
image: assets/images/image.jpg
```

Note that this image doesn't show up in the main post, it's just visible in main
page listing for the top 4 and the sticky posts. If you skip adding an image, a
default [geopattern](https://github.com/jasonlong/geo_pattern) is generated and
used instead.

[tech_blog]: https://tech.skit.ai/
[mundana]: https://github.com/wowthemesnet/mundana-theme-jekyll
