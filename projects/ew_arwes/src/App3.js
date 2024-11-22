import React, { type ReactElement, Fragment, useMemo, useState, useEffect, useRef, ReactNode } from 'react';
import { createRoot } from 'react-dom/client';
import { Animator } from '@arwes/react-animator';
import { GridLines, Dots, MovingLines } from '@arwes/react-bgs';
import { type CSSObject, Global, jsx } from '@emotion/react';
import { type FrameSVGPathGeneric } from '@arwes/frames';
import { Text } from '@arwes/react-text';
import { FrameSVG, FrameKranox, FrameSVGKranox, useFrameSVGAssemblingAnimation } from '@arwes/react-frames';
import {
  type ThemeSettingsUnit,
  type ThemeSettingsMultiplier,
  type ThemeSettingsColor,
  type ThemeSettingsStyle,
  type ThemeUnit,
  type ThemeMultiplier,
  type ThemeColor,
  type ThemeStyle,
  type ThemeCreatorStructure,
  createAppTheme,
  createCreateTheme,
  createThemeStyle, 
  createThemeUnit,
  createThemeMultiplier,
  createThemeColor,
  styleSteps,
  styleStrip,
  Animated,
  AnimatedProp,
  FrameSettings,
  FrameBase,
  FrameCorners,
  FrameNefrex,
  FrameOctagon,
  useFrameAssembler,
  styleFrameClipOctagon,
  memo,
  cx,
  Illuminator,
  BleepsProviderSettings,
  BleepsProvider,
  useBleeps,
  BleepsOnAnimator
} from '@arwes/theme';

interface ThemeSettings {
  space: ThemeSettingsUnit;
  outline: ThemeSettingsMultiplier;
  font: ThemeSettingsStyle;
  color: {
    primary: ThemeSettingsColor;
    secondary: ThemeSettingsColor;
  }
}

interface Theme {
  space: ThemeUnit;
  outline: ThemeMultiplier;
  font: ThemeStyle;
  color: {
    primary: ThemeColor;
    secondary: ThemeColor;
  };
  settings: {
    hues: {
      primary: 200,
      secondary: 80
    },
    fontFamilies: {
      title: 'Copperplate, Copper, "Comic Sans"',
      body: 'Tahoma, Techno, Trebuchet'
    }
  }
}



const themeStructure: ThemeCreatorStructure = {
  space: 'multiplier',
  outline: 'multiplier',
  font: 'style',
  color: {
    primary: 'color',
    secondary: 'color'
  }
};

const themeDefaults: ThemeSettings = {
  space: i => `${i}rem`,
  outline: 1,
  font: [
    { fontFamily: 'monospace', fontSize: '30px' },
    { fontFamily: 'sans-serif', fontSize: '21px' }
  ],
  color: {
    primary: i => [180, 70, i * 5, 1],
    secondary: i => [60, 70, i * 5, 1]
  }
};

const addStyles = (css: string) => {
	const style = document.createElement('style');
	style.innerHTML = css;
	document.body.appendChild(style);
};


const pageFrameSettings: FrameSettings = {
  elements: [
    {
      name: 'line',
      path: [
        ['M', 10, 10],
        ['h', '7%'],
        ['l', 10, 10],
        ['h', '7%']
      ]
    },
    {
      name: 'line',
      path: [
        ['M', '100%-10', 10],
        ['h', '-7%'],
        ['l', -10, 10],
        ['h', '-7%']
      ]
    },
    {
      name: 'line',
      path: [
        ['M', '100%-10', '100%-10'],
        ['h', '-7%'],
        ['l', -10, -10],
        ['h', '-7%']
      ]
    },
    {
      name: 'line',
      path: [
        ['M', '10', '100%-10'],
        ['h', '7%'],
        ['l', 10, -10],
        ['h', '7%']
      ]
    }
  ]
};




const createTheme = createCreateTheme(themeStructure, themeDefaults);
const stylesBaseline = createThemeStyle();
const style = createThemeStyle([
  { fontSize: '30px', color: 'red' },
  { fontSize: '24px', color: 'blue' },
  { fontSize: '18px', color: 'green' }
]);

const Sandbox = (): ReactElement => {
	
	
	
    const paths: FrameSVGPathGeneric[] = useMemo(() => [
      // Background shape.
      {
        name: 'bg',
        style: {
          strokeWidth: 0,
          fill: 'hsl(180, 75%, 10%)',
          filter: 'drop-shadow(0 0 2px hsl(180, 75%, 10%))'
        },
        path: [
          ['M', 20, 20],
          ['L', 20, '100% - 20'],
          ['L', '100% - 20', '100% - 20'],
          ['L', '100% - 20', 20]
        ]
      },
      // Top decoration.
      {
        name: 'line',
        style: {
          strokeWidth: '1',
          stroke: 'hsl(180, 75%, 50%)',
          fill: 'none',
          filter: 'drop-shadow(0 0 2px hsl(180, 75%, 50%))'
        },
        path: [
          ['M', 10, 10],
          ['L', '100% - 10', 10],
          ['L', '100% - 10', 40]
        ]
      },
      // Bottom decoration.
      {
        name: 'line',
        style: {
          strokeWidth: '2',
          stroke: 'hsl(180, 75%, 50%)',
          fill: 'none',
          filter: 'drop-shadow(0 0 2px hsl(180, 75%, 50%))'
        },
        path: [
          ['M', '100% - 10', '100% - 10'],
          ['L', 10, '100% - 10'],
          ['L', 10, '100% - 40']
        ]
      }
    ], []);
	
  const theme: Theme = useMemo(() => {
    const themeExtensions = {
      outline: 3
    };
    return createTheme(themeExtensions);
  }, []);
  
  const [active, setActive] = useState(true);

  useEffect(() => {
    const tid = setInterval(() => setActive(!active), active ? 5_000 : 1_000);
    return () => clearTimeout(tid);
  }, [active]);

  return (
    <Fragment>
      <Global styles={{
        html: {
          margin: theme.space(2),
			lineHeight: 1.6,
          backgroundColor: theme.color.primary(1)
        },
        h1: {
          ...theme.font(0),
          marginBottom: theme.space(1),
          borderBottomWidth: theme.outline(1),
          borderBottomStyle: 'solid',
          borderBottomColor: theme.color.primary(10),
          paddingBottom: theme.space(1),
          color: theme.color.primary(16),
          position: 'relative', // Set position to relative for stacking context
          zIndex: 10, // Ensure it's on top
          marginBottom: theme.space(1),
          borderBottomWidth: theme.outline(1),
          borderBottomStyle: 'solid',
          borderBottomColor: theme.color.primary(10),
          paddingBottom: theme.space(1),
          color: theme.color.primary(16),
          position: 'relative', // Set position to relative for stacking context
          zIndex: 10 // Ensure it's on top
        },
        p: {
          ...theme.font(1),
          color: theme.color.secondary(16),
          position: 'relative', // Set position to relative for stacking context
          zIndex: 10, // Ensure it's on top
          margin: theme.space([0, 0, 4]),
        },
        hr: {
          margin: theme.space([0, 0, 4]),
          border: 'none',
          height: 2,
          background: `linear-gradient(
            90deg,
          )`
        },		
        img: {
          margin: 0,
          maxWidth: '100%',
          borderRadius: theme.space(2)
        }
      }} />

      <Animator active={active} duration={{ enter: 1, interval: 10 }}>
        <div
          style={{
            position: 'absolute',
            inset: 0,
            backgroundColor: '#000906',
            backgroundImage:
              'radial-gradient(85% 85% at 50% 50%, hsla(185, 100%, 25%, 0.25) 0%, hsla(185, 100%, 25%, 0.12) 50%, hsla(185, 100%, 25%, 0) 100%)',
            zIndex: 1 // Ensure this is below the text
          }}
        >
          <GridLines lineColor="hsla(180, 100%, 75%, 0.05)" distance={30} />
          <Dots color="hsla(180, 100%, 75%, 0.05)" distance={30} />
          <MovingLines lineColor="hsla(180, 100%, 75%, 0.07)" distance={30} sets={20} />
        </div>
		  
      </Animator>
		  

      <Animator active={active}><Text as='h1'>Entropy Worship</Text></Animator>
      <p>Alpha Web Build 3.0</p>
      <div>
        <p style={{ ...style(0) }}>Test Mode</p>
        <p style={{ ...style(1) }}>Arwes</p>
        <p style={{ ...style(2) }}>Futuristic Sci-Fi UI Web Framework</p>
      </div>
	  <div style={{ position: 'relative', width: '300px', height: '300px', zIndex: 2 }}>
  		<FrameKranox
		 
          css={{
            '[data-name=bg]': {
              color: 'hsl(180, 100%, 10%)',
				bg: 'hsl(180, 100%, 75%, 0.2)'
            },
            '[data-name=line]': {
              color: 'hsl(180, 75%, 50%)'
            }
          }}
        />
	  </div>
    <Animator active={active}>
      <Text as='p' style={{ color: '#ddd' }}>
        Nemo enim ipsam <b>voluptatem quia voluptas</b> sit aspernatur
        aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione
        voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia
        dolor sit amet, consectetur, <b>adipisci velit, <i>sed quia non</i></b>
        numquam eius modi tempora incidunt ut labore et dolore magnam
        <span><a href='#'>aliquam quaerat</a></span> voluptatem. Ut enim ad minima
        veniam, qui nostrum exercitationem ullam corporis suscipit.
      </Text>
    </Animator>
		  <main style={{
		          padding: theme.space([4, 8]),
		          maxWidth: 400,
		          borderRadius: theme.space(4),
		          background: `linear-gradient(
		            to bottom right,
		          )`
		        }}>
		          <h1>Arwes Framework</h1>
		          <hr />
		          <p>
		            Arwes is a web framework to build user interfaces based on futuristic
		            science fiction designs, animations, and sound effects. The concepts
		            behind are opinionated with influences from Cyberprep and Synthwave,
		            and productions like Star Citizen, Halo, and TRON: Legacy. It tries to
		            inspire advanced science and technology.
		          </p>
		          <img src="https://arwes.dev/assets/images/background-large.jpg" />
		        </main>

		 

		  
        
    </Fragment>
  );
};

createRoot(document.querySelector('#root')).render(<Sandbox />);

export default Sandbox;
