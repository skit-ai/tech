class FancyAudioPlayer < Liquid::Tag
  @@player_id = 0
  def initialize(tagName, content, tokens)
    super
    @content = content
    @player_id = @@player_id + 1
    @@player_id += 1
  end

  def render(context)
    "<script>
       $(document).ready(function () {
         var ws#{@player_id} = WaveSurfer.create({
           container: '#waveform-#{@player_id}'
         });
         ws#{@player_id}.load('#{@content.strip}');

         ws#{@player_id}.on('audioprocess', function () {
           let progressText = ws#{@player_id}.getCurrentTime().toFixed(2) + ' / ' + ws#{@player_id}.getDuration().toFixed(2)
           document.getElementById('player-progress-#{@player_id}').innerHTML = progressText
         });

         ws#{@player_id}.on('ready', function () {
           let progressText = ws#{@player_id}.getCurrentTime().toFixed(2) + ' / ' + ws#{@player_id}.getDuration().toFixed(2)
           document.getElementById('player-progress-#{@player_id}').innerHTML = progressText
         });

         for (let button of document.getElementById('controls-#{@player_id}').children) {
           button.onclick = function (e) {
             let action = button.getAttribute('data-action')
             switch (action) {
               case 'play-pause':
                 ws#{@player_id}.playPause()
                 $(button).find('i:first').toggleClass('fa-play')
                 $(button).find('i:first').toggleClass('fa-pause')
                 $(button).toggleClass('btn-dark')
                 break
               case 'backward':
                 ws#{@player_id}.skipBackward()
                 break
               case 'forward':
                 ws#{@player_id}.skipForward()
                 break
             }
           }
         }
       });
     </script>
<style>
  .player-controls {
    margin: 20px 0;
  }
</style>
<div id='waveform-#{@player_id}'></div>
<div class='player-controls' id='controls-#{@player_id}'>
  <button class='btn btn-sml' data-action='backward'><i class='fa fa-backward'></i></button>
  <button class='btn btn-sml' data-action='play-pause'><i class='fa fa-play'></i></button>
  <button class='btn btn-sml' data-action='forward'><i class='fa fa-forward'></i></button>
  <code class='btn btn-sml disabled' id='player-progress-#{@player_id}'></code>
</div>
"
  end

  Liquid::Template.register_tag "fancy_audio", self
end
