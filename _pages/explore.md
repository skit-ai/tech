---
title: "Explore"
layout: page
permalink: "/explore/"
---
<script src="https://cdnjs.cloudflare.com/ajax/libs/geopattern/1.2.3/js/geopattern.min.js"></script>

Explore Speech Technologies from Skit.

<br>

## Conversational AI

<br>

<div class="row">
  <div class="col-sm-4">
    <div class="explore-card">
    <a href="/speech-conversational-llms/">
      <div class="explore-card-banner"></div>
      <div class="explore-card-content">
        <h4 class="explore-card-title">Speech LLMs</h4>
        <div class="explore-card-description">
          Multimodal-LLMs for speech-first Conversational AI
        </div>
        <div class="explore-card-date-parent">
          <span class="explore-card-date">2024</span>
        </div>
      </div>
    </a>
    </div>
  </div>
</div>

<br>

## Response Production

<br>

<div class="row">
  <div class="col-sm-4">
    <div class="explore-card">
    <a href="/explore/emotional-tts">
      <div class="explore-card-banner"></div>
      <div class="explore-card-content">
        <h4 class="explore-card-title">Emotional TTS</h4>
        <div class="explore-card-description">
          Use emotion presets and variations to deliver the right tonality in your
          dialog system.
        </div>
        <div class="explore-card-date-parent">
          <span class="explore-card-date">2021</span>
        </div>
      </div>
    </a>
    </div>
  </div>

    <div class="col-sm-4">
      <div class="explore-card">
      <a href="/explore/voice-cloning">
        <div class="explore-card-banner"></div>
        <div class="explore-card-content">
          <h4 class="explore-card-title">Voice Cloning</h4>
          <div class="explore-card-description">
            Voice cloning enables one to generate synthesised speech in their voice using minimal data.
          </div>
          <div class="explore-card-date-parent">
            <span class="explore-card-date">2021</span>
          </div>
        </div>
      </a>
    </div>
  </div>

    <div class="col-sm-4">
      <div class="explore-card">
      <a href="/explore/natural-tts">
        <div class="explore-card-banner"></div>
        <div class="explore-card-content">
          <h4 class="explore-card-title">Natural TTS</h4>
          <div class="explore-card-description">
            We have state of the art performance in Naturalness for a TTS system.
          </div>
          <div class="explore-card-date-parent">
            <span class="explore-card-date">2021</span>
          </div>
        </div>
      </a>
    </div>
  </div>
</div>

<br>

## Behaviors and Personalities

<br>


<div class="row">
  <div class="col-sm-4">
    <div class="explore-card">
    <a href="/explore/speaker-entrainment">
      <div class="explore-card-banner"></div>
      <div class="explore-card-content">
        <h4 class="explore-card-title">Speaker Entrainment</h4>
        <div class="explore-card-description">
          Speaker entrainment attunes the bot to the features in the user's speech.
        </div>
        <div class="explore-card-date-parent">
          <span class="explore-card-date">2021</span>
        </div>
      </div>
    </a>
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
