class MIDIOutController {  
  constructor(midiDevice) {
    this.midiDevice = midiDevice;
  }
  
  sendMidiMessage(pitch, velocity, duration) {
    const NOTE_ON = 0x90;
    const NOTE_OFF = 0x80;
    
    const device = midiOut[selectOut.selectedIndex];
    const msgOn = [NOTE_ON, pitch, velocity];
    const msgOff = [NOTE_ON, pitch, velocity];
    
    // First send the note on;
    this.midiDevice.send(msgOn); 
    
    // Then send the note off. You can send this separately if you want 
    // (i.e. when the button is released)
    this.midiDevice.send(msgOff, Date.now() + duration); 
  }
}