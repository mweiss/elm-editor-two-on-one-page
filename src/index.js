import './css/reset.css';
import './css/main.css';
import './css/demo.css';
import './css/rte.css';
import './css/modal.css';

import '@webcomponents/webcomponentsjs/webcomponents-bundle.js'
import '@webcomponents/webcomponentsjs/custom-elements-es5-adapter.js'
import { Elm } from './Main.elm';
import 'elm-rte-toolkit';

Elm.Main.init({
  node: document.getElementById('root')
});
