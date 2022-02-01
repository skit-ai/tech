---
title: "Speaker Entrainment"
layout: page
permalink: "/explore/speaker-entrainment"
fancy_audio_player: True
---

Speaker entrainment is a phenomenon observed in human-human conversations where one interlocutor attunes their speech's acoustic, lexical and semantic features to the other interlocutor.

This project aims to create a bot which can entrain on the acoustic features of user's speech. Incorporating such behavior into bots is known to increase trust, naturalness and likeability, which is likely to increase customer satisfaction and call resolution rate.

<br>

## Baseline Module
<br/>
The following audio samples are generated from the Baseline entrainment module, which entrains over pitch (fundamental frequency), intensity (loudness) and rate of articulation.
<br/>
<br/>

### Demo Audio Samples
<br/>
<p><b>Script-1:</b> Entraining over pitch (fundamental frequency) in this audio sample, entrained performs better. In this script, the pitch of the user is rising and the bot attunes itself to that. </p>
<table style="width:100%">
      <tr>
        <th>Not Entrained</th>
        <th>Entrained</th>
      </tr>
      <tr>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://p1-tts-experiments.s3.ap-south-1.amazonaws.com/demo/speaker-entrainment/script-1-non.wav" type="audio/mpeg">
            Your browser does not support the audio element.
          </audio>
        </th>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://p1-tts-experiments.s3.ap-south-1.amazonaws.com/demo/speaker-entrainment/script-1-en.wav" type="audio/mpeg">
            Your browser does not support the audio element.
          </audio>
        </th>
      </tr>
    </table>
<hr>

<p><b>Script-2:</b> Entraining over intensity (loudness) and rate of articulation in this audio sample, entrained performs better. In this script, both the intensity and rate of articulation decrease, and the bot attunes itself to that. </p>
<table style="width:100%">
      <tr>
        <th>Not Entrained</th>
        <th>Entrained</th>
      </tr>
      <tr>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://p1-tts-experiments.s3.ap-south-1.amazonaws.com/demo/speaker-entrainment/script-8-non.wav" type="audio/mpeg">
            Your browser does not support the audio element.
          </audio>
        </th>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://p1-tts-experiments.s3.ap-south-1.amazonaws.com/demo/speaker-entrainment/script-8-en.wav" type="audio/mpeg">
            Your browser does not support the audio element.
          </audio>
        </th>
      </tr>
    </table>
<hr>

<p><b>Script-3:</b> Entraining over intensity and pitch in this audio sample, the non-entrained performs better. In this script, the pitch rises and the intensity falls. This is an example of how stray artefacts can decrease the quality of speaker entrainment modules, since the sharp pitch increase in the last bot-turn makes this exchange fairly unnatural. </p>
<table style="width:100%">
      <tr>
        <th>Not Entrained</th>
        <th>Entrained</th>
      </tr>
      <tr>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://p1-tts-experiments.s3.ap-south-1.amazonaws.com/demo/speaker-entrainment/script-9-non.wav" type="audio/mpeg">
            Your browser does not support the audio element.
          </audio>
        </th>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://p1-tts-experiments.s3.ap-south-1.amazonaws.com/demo/speaker-entrainment/script-9-en.wav" type="audio/mpeg">
            Your browser does not support the audio element.
          </audio>
        </th>
      </tr>
    </table>
<hr>

<br/>
