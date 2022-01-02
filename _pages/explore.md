---
title: "Explore"
layout: page
permalink: "/explore"
---
<script src="https://cdnjs.cloudflare.com/ajax/libs/geopattern/1.2.3/js/geopattern.min.js"></script>

Explore Speech Technologies from Skit. _More items coming soon_.

<br>

<div class="row justify-content-center">
  <div class="col-md-4">
    <a href="/explore/emotional-tts">
    <div class="explore-card">
      <div class="explore-card-banner"></div>
      <div class="explore-card-content">
        <h4 class="explore-card-title">Emotional TTS</h4>
        <div class="explore-card-description">
          Use emotion presets and variations to deliver the right tonality in your
          dialog system.
        </div>
      </div>
    </div>
    </a>
  </div>

  <div class="col-md-4">
    <div class="explore-card">
      <div class="explore-card-banner"></div>
      <div class="explore-card-content">
        <h4 class="explore-card-title">Work In Progress</h4>
        <div class="explore-card-description">
          ...
        </div>
      </div>
    </div>
  </div>
</div>

<script>
$('.explore-card').each(function () {
  let card = $(this)
  let title = card.find('.explore-card-title').first().text()
  let pattern = GeoPattern.generate(title)
  card.find('.explore-card-banner').css('background-image', pattern.toDataUrl())
})
</script>
