import React, { ReactElement, Fragment, useMemo } from 'react';
//From createAppTheme
import { PartialDeep } from '@arwes/tools';
//From createAppTheme
import { deepExtend } from './deepExtend';
import { createRoot } from 'react-dom/client';
import { Global } from '@emotion/react';
import {
  ThemeSettingsUnit,
  ThemeSettingsMultiplier,
  ThemeSettingsColor,
  ThemeSettingsStyle,
  ThemeUnit,
  ThemeMultiplier,
  ThemeColor,
  ThemeStyle,
  ThemeCreatorStructure,
  createCreateTheme
} from '@arwes/theme';


interface ThemeSettings {
  space: ThemeSettingsUnit,
  outline: ThemeSettingsMultiplier,
  font: ThemeSettingsStyle,
  color: {
    primary: ThemeSettingsColor,
    secondary: ThemeSettingsColor,
    success: ThemeSettingsColor,
    info: ThemeSettingsColor,
    warning: ThemeSettingsColor,
    error: ThemeSettingsColor

  }
}

interface Theme {
  space: ThemeUnit,
  outline: ThemeMultiplier,
  font: ThemeStyle,
  color: {
    primary: ThemeColor,
    secondary: ThemeColor,
    success: ThemeColor,
    info: ThemeColor,
    warning: ThemeColor,
    error: ThemeColor
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
  // Values to be multiplied by a provided integer.
  space: i => `${i}rem`,
  outline: 1,
  // A list of styles with any CSS properties.
  // fonts to test: Copperplate, Copper, "Comic Sans", "Tahoma, Techno, Trebuchet"
  font: [
    { fontFamily: 'Copperplate', fontSize: '30px' },
    { fontFamily: 'Segoe UI Web (West European)', fontSize: '21px' },
    { fontFamily: 'Menlo', fontSize: '21px' },
    { fontFamily: 'Tomorrow', fontSize: '18px' }
  ],
  color: {
    // A function to return a HSLA value as [number, number, number, number?].
    primary: i => [280, 70, i * 5, 1],
    secondary: i => [130, 70, i * 5, 1],
    success: i => [30, 70, i * 5, 1],
    info: i => [70, 70, i * 5, 1],
    warning: i => [50, 70, i * 5, 1],
    error: i => [160, 70, i * 5, 1]
    }
};

const createTheme = createCreateTheme(themeStructure, themeDefaults);

const Sandbox = (): ReactElement => {
  const theme: Theme = useMemo(() => {
    const themeExtensions = {
      outline: 3
    };
    const theme = createTheme(themeExtensions);
    return theme;
  }, []);

  return (
    <Fragment>
      <Global styles={{
        html: {
          margin: theme.space(2),
          //backgroundColor: theme.color.primary(1),
          zIndex: (-100)
        },
        h1: {
          ...theme.font(0),
          marginBottom: theme.space(1),
          borderBottomWidth: theme.outline(1),
          borderBottomStyle: 'solid',
          borderBottomColor: theme.color.primary(10),
          paddingBottom: theme.space(1),
          color: theme.color.primary(16)
        },
        h2: {
          ...theme.font(1),
          color: theme.color.secondary(6)
        },
        h3: {
          ...theme.font(3),
          color: theme.color.secondary(6)
        },
        h4: {
          ...theme.font(3),
          color: theme.color.secondary(6)
        },
        h5: {
          ...theme.font(3),
          color: theme.color.secondary(6)
        },
        h6: {
          ...theme.font(3),
          color: theme.color.secondary(6)
        },
        p: {
          ...theme.font(1),
          color: theme.color.secondary(6)
        },
        ul: {
          ...theme.font(1),
          color: theme.color.secondary(6)
        },
        li: {
          ...theme.font(1),
          color: theme.color.secondary(6)
        },
        ol: {
          ...theme.font(1),
          color: theme.color.secondary(6)
        },

        pre: {
          ...theme.font(2),
          display: "block",
          color: theme.color.secondary(16),
          borderBottomWidth: theme.outline(1),
          borderBottomStyle: "solid",
          borderBottomColor: theme.color.primary(10),
          paddingBottom: theme.space(1),
          color: theme.color.primary(16),
          borderTopWidth: theme.outline(1),
          borderRightWidth: 0,
          borderTopStyle: "solid",
          borderTopColor: theme.color.primary(6),
          borderBottomColor: theme.color.primary(6),
          paddingTop: theme.space(1),
          fontSize: 12,
          backgroundImage: "linearGradient(to right, rgba(82, 94, 101, 0.1), rgba(17, 20, 21, 0.1))"
        },
        blockquote: {
          ...theme.font(1),
          color: theme.color.secondary(6)
        },
        table: {
          ...theme.font(1),
          color: theme.color.secondary(6),
          borderTopWidth: '0.2rem',
          borderRightWidth: '0.2rem',
          borderBottomWidth: '0.2rem',
          borderLeftWidth: '0.2rem',
          borderTopStyle: 'solid',
          borderRightStyle: 'solid',
          borderBottomStyle: 'solid',
          borderLeftStyle: 'solid',
          borderTopColor: 'rgb(23, 26, 28)',
          borderRightColor: 'rgb(23, 26, 28)',
          borderBottomColor: 'rgb(23, 26, 28)',
          borderLeftColor: 'rgb(23, 26, 28)',
          backgroundColor: 'rgb(23, 26, 28)',
          //transitionProperty: 'color', 'backgroundColor', 'borderColor', 'textDecorationColor', 'fill', 'stroke', 'opacity', 'boxShadow', 'transform', 'filter', 'backdropFilter', 'outline',
          transitionTimingFunction: 'easeOut',
          transitionDuration: '0.15s'
        },
        figcaption: {
          ...theme.font(1),
          color: theme.color.secondary(6)
        }
      }} />
    </Fragment>
  );
};
createRoot(document.querySelector('#root')).render(<Sandbox />);

export default Sandbox;