// app/javascript/controllers/share_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["title", "body"];

  async share() {
    const title = this.titleTarget.textContent;
    const body = this.bodyTarget.textContent;
    const url = this.data.get("urlValue");

    try {
      await navigator.share({
        title,
        text: body,
        url,
      });
    } catch (err) {
      console.error("Sharing failed:", err);
    }
  }
}
