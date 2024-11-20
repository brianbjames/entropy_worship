import './App.css';
import './crypt-ui.css';
import EWGlobalStyles from './EWGlobalStyles';
import EWPuffs from './EWPuffs';
//import EWButton from './EWButton';
import UAT from './UAT';
import { createRoot } from 'react-dom/client';
import React, { type ReactElement, useState, useEffect } from 'react';
import { Animator } from '@arwes/react-animator';
import { Puffs } from '@arwes/react-bgs';

function Sandbox() {
  return (

    <div>
      
      <div>
    
      <div class="container">
        <h1 class="heading">ENTROPY WORSHIP</h1>
        <h1 class="panel info shown">Web Build 2.0.10.21.2024</h1>
        <div class="panel error shown">
            <div class="header">
                <h3 class="title">Alert</h3>
            </div>
            <div class="body">
                <button class="button alert">New Album Release November 22</button>
            </div>
        </div>

        
        <div class="panel info shown">
         <div class="header">
        <h3 class="title">Releases</h3>
        </div>
            <div class="body"> 
        <div class="container">
        
            
            <div class="container">
                <img src="https://www.entropyworship.com/images/EntropyWorshipFacticity-CoverForDigitalSmaller.jpg"></img>
                <h4>Facticity Devotion Discipline - EP</h4>
                <a href="https://www.missionsynths.com/products/entropy-worship-facticity-devotion-discipline-1" target="_blank"><button class="button">Order Vinyl</button></a>
                <a href="https://entropyworship.bandcamp.com/album/facticity-devotion-discipline" target="_blank"><button class="crypt-button button secondary">Download</button></a>
            </div>
            
            
            <div class="container">
                <img src="https://www.entropyworship.com/images/EntropyWorshipDirtyConsecrationCover.jpg"></img>
                <h4>Dirty Consecration - Single</h4>
                <a href="https://entropyworship.bandcamp.com/album/dirty-consecration" target="_blank"><button class="button">Download</button></a> 
            </div>
            
            
            <div class="container">
                <img src="https://www.entropyworship.com/images/EntropyWorshipThamesCover.jpg"></img>
                <h4>Thames and Variations - Single</h4>
                <a href="https://entropyworship.bandcamp.com/album/thames-and-variations" target="_blank"><button class="button">Download</button></a> 
            </div>
            
        </div>
        </div>
        </div>
        <div class="panel info shown">
            <div class="header">
                <h3 class="title">Links</h3>
            </div>
        <div class="body">
        <a href="https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewArtist?id=1110835320&mt=1&ls=1&app=music" target="_blank"><button class="button">Apple Music</button></a>  
		<a href="https://open.spotify.com/artist/3GpPdNZsECtcabm7mZOwGI" target="_blank"><button class="button">Spotify</button></a> 
		<a href="https://soundcloud.com/entropy-worship" target="_blank"><button class="button">Soundcloud</button></a> 
		<a href="https://entropyworship.bandcamp.com" target="_blank"><button class="button">Bandcamp</button></a>
		<a href="https://www.facebook.com/entropyworship/" target="_blank"><button class="button">Facebook</button></a>
		<a href="https://ra.co/dj/entropyworship" target="_blank"><button class="button">Resident Advisor</button></a>
		<a href="https://twitter.com/EntropyWorship" target="_blank"><button class="button">Twitter</button></a>
		<a href="https://www.instagram.com/entropyworship/" target="_blank"><button class="button">Instagram</button></a> 
		<a href="/EW_Press_Kit.pdf" target="_blank"><button class="button">Press Kit</button></a> 
		<a href="mailto:brian@entropyworship.com" target="_blank"><button class="button">Booking</button></a> 
            </div>
        </div>


        <div class="panel info shown">
            <div class="header">
                <h3 class="title">EW909</h3>
            </div>
            <div class="body">JavaScript 909 Quasi-Clone
                <a href="https://www.entropyworship.com/EW909.html" target="_blank"><button class="button">Open</button></a>
            </div>
        </div>
        
        <div class="panel info shown">
            <div class="header">
                <h3 class="title">Performance Schedule</h3>
            </div>
            <div class="body">
 		Nov 20 2024: Wednesday Night Live @ KZSU Stanford, 90.1 FM, 9pm PST <a href="http://kzsu.stanford.edu/~wnl/" target="_blank">More Info</a>     
		Aug 17 2024:  DOMAIN: Jay Denham, Tyrel Williams, Oso Feo, Miagma, Entropy Worship @ F8, 1192 Folsom, San Francisco, CA <a href="https://www.ra.co/events/1964938" target="_blank">More Info</a>
		Jul 27 2024:  Broom & Board 4.0 @ TBA Campout Location <a href="http://www.haggardsolutions.com" target="_blank">More Info</a>
		Mar 22 2024:  PreMovement: Luke Hess, Patrick Gil, Entropy Worship, Victor V. b2b Dr.Rek @ Underground SF, 424 Haight St. San Francisco, CA <a href="https://www.facebook.com/events/2441349452715891" target="_blank">More Info</a>
		Jan 11 2024:  Free! Prox. Happy Hour w/ Entropy Worship - 888 - Alcoves @ Underground SF, 424 Haight St. San Francisco, CA <a href="https://www.facebook.com/events/1033807594362929" target="_blank">More Info</a>
		Nov 25 2023:  Future Fatigue - Hardware Live Acts - Vinyl DJ Sets @ Spire, 285 Athens Ave, Oakland, CA <a href="https://www.facebook.com/events/702368038168013/" target="_blank">More Info</a>
		Sep 09 2023:  909 @ Edinburgh Castle, 950 Geary, San Francisco, CA
		Feb 11 2023:  Subliminal Content: Bunker Underground @ Undislosed Location, San Francisco, CA  
		Jan 03 2020:  Mirror Room Edits: Fundraiser Party @ F8, 1192 Folsom, San Francisco, CA <a href="https://www.facebook.com/events/454130828849367/" target="_blank">More Info</a>
		Dec 06 2019:  Asterisk 018: Traversable Wormhole Live, Entropy Worship Live @ F8, 1192 Folsom, San Francisco, CA <a href="https://www.facebook.com/events/433231917301460/" target="_blank">More Info</a>
		Sep 27 2019:  Broom & Board 2.0: The Dustpan @ TBA Campout Location <a href="http://www.haggardsolutions.com" target="_blank">More Info</a>		
		Mar 30 2019:  Direct To Earth Late Night @ Club 6, San Francisco, CA <a href="https://www.facebook.com/events/286743858685698/" target="_blank">More Info</a>
		Feb 25 2019:  Visions of a New World @ Underground SF, 424 Haight, San Francisco, CA <a href="https://www.facebook.com/events/307939623248208/" target="_blank">More Info</a>
		Feb 09 2019:  Day of Noise @ KZSU Stanford, 90.1 FM, midnight PST <a href="http://kzsu.stanford.edu/dayofnoise/2019/" target="_blank">More Info</a>                   
		May 12 2018: In Too Deep @ Studio Grand, 3234 Grand, Oakland, CA <a href="https://www.facebook.com/events/375195919629612/" target="_blank">More Info</a>
		May 02 2018: IDP 019: Unofficial Mutek Pre-Party @ Hyde Street Studios, 245 Hyde, San Francisco, CA <a href="https://www.facebook.com/events/183711188930280/" target="_blank">More Info</a>   
		Apr 05 2018: Asterisk 007: 1 YR Anniversary @ F8, 1192 Folsom, San Francisco, CA <a href="https://www.facebook.com/events/1724155357642488/" target="_blank">More Info</a> 
		Feb 10 2018: Day of Noise @ KZSU Stanford, 90.1 FM, midnight PST <a href="http://kzsu.stanford.edu/dayofnoise/2018/" target="_blank">More Info</a>
		Dec 22 2017: Surface Tension @ F8, 1192 Folsom, San Francisco, CA <a href="https://www.facebook.com/events/384903235301201/" target="_blank">More Info</a>
		Dec 20 2017: Wednesday Night Live @ KZSU Stanford, 90.1 FM, 9pm PST <a href="http://kzsu.stanford.edu/~wnl/" target="_blank">More Info</a>
		July 08 2017: IDP 015 @ Hyde Street Studios, 245 Hyde, San Francisco, CA <a href="https://www.facebook.com/events/136732650216294/" target="_blank">More Info</a>
		Jan 31 2017: Day of Noise @ KZSU Stanford, 90.1 FM, midnight PST <a href="http://kzsu.stanford.edu/dayofnoise/2017/" target="_blank">More Info</a>  
            </div>
        </div>
      
        <div class="panel info shown">
            <div class="header">
                <h3 class="title">About</h3>
            </div>
            <div class="body">
                Entropy Worship is an experimental project by San Francisco-based artist Brian B. James. 
                All content © 2024, Entropy Worship
            </div>
        </div>
      </div>
      <h1>HTML UI Elements Example</h1>

<div class="ui-element">
    <h2>1. Text Input</h2>
    <input type="text" placeholder="Enter your name" />
</div>

<div class="ui-element">
    <h2>2. Password Input</h2>
    <input type="password" placeholder="Enter your password" />
</div>

<div class="form crypt-form-field stacked"> <label for="form-field">Name</label> <input id="form-field" placeholder="Enter your name..."/> </div>


<div class="ui-element">
    <h2>4. Number Input</h2>
    <input type="number" placeholder="Enter a number" />
</div>

<div class="ui-element">
    <h2>5. Radio Buttons</h2>
    <label><input type="radio" name="gender" value="male" /> Male</label>
    <label><input type="radio" name="gender" value="female" /> Female</label>
</div>


<div class="ui-element">
    <h2>6. Checkbox</h2>
    <label><input type="checkbox" /> I agree to the terms and conditions</label>
</div>

<div class="ui-element">
    <h2>7. Dropdown Menu</h2>
    <select>
        <option value="">Select your country</option>
        <option value="usa">United States</option>
        <option value="canada">Canada</option>
        <option value="uk">United Kingdom</option>
    </select>
</div>

<div class="ui-element">
    <h2>8. Textarea</h2>
    <textarea rows="4" cols="50" placeholder="Write your message here..."></textarea>
</div>

<div class="ui-element">
    <h2>9. Button</h2>
    <button onclick="alert('Button clicked!')">Click Me</button>
</div>

<div class="ui-element">
    <h2>10. Submit Button</h2>
    <form onsubmit="alert('Form submitted!'); return false;">
        <input type="submit" value="Submit" />
    </form>
</div>
    <UAT />

      
    </div>
    </div>
  );
  }
  
  createRoot(document.querySelector('#root')).render(<Sandbox />);

  export default Sandbox;
  