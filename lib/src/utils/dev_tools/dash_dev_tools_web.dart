import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;
import 'dash_dev_tools_interface.dart';

class DashDevToolsImpl implements DashDevToolsInterface {
  bool _isInjected = false;

  @override
  void enable() {
    if (!kDebugMode) return;

    _injectDevToolsJS();
    final window = web.window;

    if (window.hasProperty('enableDashDevTools'.toJS) == true.toJS) {
      window.callMethod('enableDashDevTools'.toJS);
    }
  }

  @override
  void disable() {
    if (!kDebugMode) return;
    final window = web.window;

    if (window.hasProperty('disableDashDevTools'.toJS) == true.toJS) {
      window.callMethod('disableDashDevTools'.toJS);
    }
  }

  @override
  bool isEnabled() {
    if (!kDebugMode) return false;
    final window = web.window;

    if (window.hasProperty('dashDevToolsIsEnabled'.toJS) == true.toJS) {
      return window.getProperty('dashDevToolsIsEnabled'.toJS) == true.toJS;
    }
    return false;
  }

  @override
  void refreshOverlay() {
    if (isEnabled()) {
      final window = web.window;
      if (window.hasProperty('drawOverlay'.toJS) == true.toJS) {
        window.callMethod('drawOverlay'.toJS);
      } else {
        print("Function 'drawOverlay' is not defined on window.");
      }
    }
  }

  void _injectDevToolsJS() {
    if (_isInjected) return;
    _injectRecorderJS();
    final window = web.window;
    final document = window.document;

    final script = document.createElement('script') as web.HTMLScriptElement;

    script.text = '''
      window.dashDevToolsInjected = true;
      
      function enableDashDevTools() {
          window.dashDevToolsIsEnabled = true;
          drawOverlay();
      }

      function disableDashDevTools() {
          window.dashDevToolsIsEnabled = false;
          clearOverlay();
      }

      function drawOverlay() {
      console.log("Drawing Overlay");
          clearOverlay();
          const overlay = document.createElement("div");
          overlay.id = "dash-devtools-overlay";
          document.body.appendChild(overlay);

          window.dashRecords.forEach(item => {
              const box = document.createElement("div");
              box.style.position = "absolute";
              box.style.left = item.x + "px";
              box.style.top = item.y + "px";
              box.style.width = item.width + "px";
              box.style.height = item.height + "px";
              box.style.border = "2px dashed red";
              box.style.pointerEvents = "none";
              box.style.zIndex = "9999";

              const label = document.createElement("span");
              label.style.position = "absolute";
              label.style.background = "rgba(0, 0, 0, 0.7)";
              label.style.color = "white";
              label.style.fontSize = "12px";
              label.style.padding = "2px 4px";
              label.style.borderRadius = "4px";
              label.textContent = item.text || item.tag;
              box.appendChild(label);

              overlay.appendChild(box);
          });
      }

      function clearOverlay() {
          const existing = document.getElementById("dash-devtools-overlay");
          if (existing) existing.remove();
      }

      function addToggle() {
        const container = document.createElement("div");
        document.body.appendChild(container);

        Object.assign(container.style, {
            position: "fixed",
            top: "10px",
            right: "10px",
            background: "white",
            padding: "5px 10px",
            border: "1px solid #ccc",
            borderRadius: "5px",
            boxShadow: "0 2px 5px rgba(0, 0, 0, 0.2)",
            display: "flex",
            alignItems: "center",
            gap: "5px"
        });

        const label = document.createElement("label");
        label.textContent = "Overlay"; // Add space for better click target
        container.appendChild(label);

        const checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.checked = true;

        label.prepend(checkbox);

        checkbox.addEventListener("change", function() {
          if(this.checked) {
            document.getElementById('dash-devtools-overlay').style.display = 'block';
          } else {
            document.getElementById('dash-devtools-overlay').style.display = 'none';
          }
        });
      }

      addToggle();

    ''';

    document.body!.appendChild(script);
    _isInjected = true;
    print("Dashhost DevTools JS Injected!");
  }

  void _injectRecorderJS() {
    final window = web.window;
    final document = window.document;

    final script = document.createElement('script') as web.HTMLScriptElement;

    script.text = '''
      
      window.dashRecordingEnabled = true;
      window.dashRecords = [];

      window.recordDashText = (data) => {
          const d = JSON.parse(data);
          window.dashRecords.push({...d, type: 'text'});
      }

      window.recordDashBox = (data) => {
          const d = JSON.parse(data);
          console.log(d);
          window.dashRecords.push({...d, type: 'box'});
      }

       window.recordDashMetaTag = (data) => {
          const d = JSON.parse(data);
          console.log(d);
          window.dashRecords.push({...d, type: 'metatag'});
      }
    ''';

    document.body!.appendChild(script);
  }
}
