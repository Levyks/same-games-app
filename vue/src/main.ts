import { createApp } from 'vue';
import { createPinia } from 'pinia';
import { vue3Debounce } from 'vue-debounce';
import App from './App.vue';
import './main.scss';

const app = createApp(App);
app.use(createPinia());
app.directive('debounce', vue3Debounce({ lock: true }));

app.mount('#app');
