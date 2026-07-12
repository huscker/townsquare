import Vue from "vue";
import VueI18n from "vue-i18n";
import en from "./en";
import ru from "./ru";

Vue.use(VueI18n);

const savedLocale =
  (typeof window !== "undefined" &&
    window.RUNTIME_CONFIG &&
    window.RUNTIME_CONFIG.defaultLanguage) ||
  (typeof localStorage !== "undefined" && localStorage.getItem("language")) ||
  "en";

export default new VueI18n({
  locale: savedLocale,
  fallbackLocale: "en",
  messages: { en, ru },
  silentFallbackWarn: true,
});
