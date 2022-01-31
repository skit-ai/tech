---
title: "Speaker Entrainment"
layout: page
permalink: "/explore/speaker-entrainment"
fancy_audio_player: True
---

Speaker entrainment is a phenomenon observed in human-human conversations where one interlocutor attunes their speech's acoustic and semantic features to the other interlocutor.

This project aims to create a bot which can entrain on the user's speech. 

<br>

## Baseline Module
<br/>
The following audio samples are generated from the Baseline entrainment module, which entrains over 
<br/>
<br/>

### Demo Audio Samples
<br/>
<p><b>Script-1:</b> Entraining over pitch (fundamental frequency) in this audio sample, entrained performs better. </p>
<table style="width:100%">
      <tr>
        <th>Not Entrained</th>
        <th>Entrained</th>
      </tr>
      <tr>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://s3.console.aws.amazon.com/s3/object/p1-tts-experiments?region=ap-south-1&prefix=demo/speaker-entrainment/script-1-non.wav" type="audio/wav">
            Your browser does not support the audio element.
          </audio>
        </th>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://s3.console.aws.amazon.com/s3/object/p1-tts-experiments?region=ap-south-1&prefix=demo/speaker-entrainment/script-1-en.wav" type="audio/wav">
            Your browser does not support the audio element.
          </audio>
        </th>
      </tr>
    </table>
<hr>

<p><b>Script-2:</b> Entraining over intensity (loudness) and rate of articulation in this audio sample, entrained performs better. </p>
<table style="width:100%">
      <tr>
        <th>Not Entrained</th>
        <th>Entrained</th>
      </tr>
      <tr>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://s3.console.aws.amazon.com/s3/object/p1-tts-experiments?region=ap-south-1&prefix=demo/speaker-entrainment/script-8-non.wav" type="audio/wav">
            Your browser does not support the audio element.
          </audio>
        </th>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://s3.console.aws.amazon.com/s3/object/p1-tts-experiments?region=ap-south-1&prefix=demo/speaker-entrainment/script-8-en.wav" type="audio/wav">
            Your browser does not support the audio element.
          </audio>
        </th>
      </tr>
    </table>
<hr>

<p><b>Script-3:</b> Entraining over intensity and pitch in this audio sample, the non-entrained performs better. </p>
<table style="width:100%">
      <tr>
        <th>Not Entrained</th>
        <th>Entrained</th>
      </tr>
      <tr>
        <th>
          <audio controls style="width: 350px;">
            <source src="https://s3.console.aws.amazon.com/s3/object/p1-tts-experiments?region=ap-south-1&prefix=demo/speaker-entrainment/script-8-non.wav" type="audio/wav">
            Your browser does not support the audio element.
          </audio>
        </th>
        <th>
          <audio controls style="width: 350px;">
            <source src="ttps://s3.console.aws.amazon.com/s3/object/p1-tts-experiments?region=ap-south-1&prefix=demo/speaker-entrainment/script-8-en.wav" type="audio/wav">
            Your browser does not support the audio element.
          </audio>
        </th>
      </tr>
    </table>
<hr>

<br/>