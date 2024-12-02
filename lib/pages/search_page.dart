
import 'dart:ffi';

import 'package:bestloop_app/loop_card_list.dart';
import 'package:bestloop_app/loop_files/loop_data_dictionary.dart';
import 'package:bestloop_app/loopcard.dart';
import 'package:bestloop_app/shared.dart';
import 'package:flutter/material.dart';

List<String> audioKeywords = [
  // General Audio Terms
  "waveform", "frequency", "pitch", "amplitude", "signal", "sample", 
  "spectrum", "harmonics", "modulation", "resonance", "synthesis", 
  "oscillator", "envelope", "decay", "attack", "release", "sustain",
  "filter", "cutoff", "resonance", "compression", "limiter", "reverb",
  "delay", "distortion", "equalizer", "gain", "loudness", "mix", 
  "normalization", "phase", "pan", "stereo", "mono", "loop", 
  "crossfade", "granular", "sequencer", "bitrate", "sample rate", 
  "ADSR", "DSP", "vocoder", "saturation", "dynamics", "waveform editing",

  // Keywords starting with "T"
  "tone", "tempo", "transient", "timbre", "track", "trigger", "threshold", 
  "tape", "time-stretching", "trim", "tuner", "toms", "triangle wave", 
  "tremolo", "tap tempo", "tuning", "tempo sync", "tempo map", "thresh", 
  "time-domain analysis", "timestretch", "track grouping", 
  "transport control", "track automation", "tone generator", 
  "truncation", "tap delay", "tonal balance", "tube distortion",

  // Specific Sound Types and Formats
  "drums", "kick", "snare", "hi-hat", "bass", "synth", "vocal", 
  "pluck", "chord", "pad", "lead", "arpeggio", "field recording", 
  "sound effects", "Foley", "ambiances", "beats", "loops", "stems", 
  "multi-tracks", "acapella", "instrumental", "midi", "wav", "mp3", 
  "flac", "ogg", "aiff",

  // Advanced Processing
  "sidechain", "multiband", "parallel processing", "noise gate", 
  "exciter", "de-esser", "spectral editing", "noise reduction", 
  "audio restoration", "pitch shift", "formant shift", 
  "time-domain processing", "frequency-domain processing"
];


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() =>
      _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _keywords = audioKeywords;
  bool _isSearching = true;
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _controller = TextEditingController();
  List<String> _filteredKeywords = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterKeywords);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  void _filterKeywords() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredKeywords = _keywords
          .where((keyword) => keyword.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                //TODO: Make back button tappable
                const Icon(Icons.arrow_back_ios_new),
                const SizedBox(width: 16,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(22)
                    ),
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search keywords...",
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                      onSubmitted: (value){
                        //TODO: Make an actual search query occur (nash its not what it looks like)
                        setState(() {
                          _isSearching = false;
                        });
                      },
                      onTap: (){
                        setState(() {
                          _isSearching = true;
                        });
                      },
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SizedBox(width: 32,),
              ],
            ),
            SizedBox(height: 10),
            if (_isSearching)
            Expanded(
              child: ListView.builder(
                itemCount: _filteredKeywords.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredKeywords[index], style: Theme.of(context).textTheme.bodyLarge,),
                    onTap: () {
                      _controller.text = _filteredKeywords[index];
                      _filteredKeywords.clear();
                      setState(() {
                        _isSearching = false;
                      });
                    },
                  );
                },
              ),
            ),
            if (!_isSearching)
            Expanded(
              child: ListView(
                children: [LoopCard(loopData: loopDataDictionary["Chill Vibes"]!)],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
