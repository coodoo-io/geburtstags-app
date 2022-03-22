# Geburtstags App

App für Geburtstagerinnerungen

## Arbeitsschritte für Riverpod

- Nicht riverpod sondern flutter_riverpod verwenden (pubassist vscode-plugin nutzen)
- Unterschiedliche Provider kennlernen:
  - [Offizielle Doku zu Provider-Typen](https://riverpod.dev/docs/concepts/providers)
  - [Simple Erklärung der Provider-Typen](https://itnext.io/a-minimalist-guide-to-riverpod-4eb24b3386a1)
  - [Dartpad Beispiel](https://dartpad.dev/?id=cd81ba65835c029422b0aac045b36547)
- Migration zu ChangeNotifierProvider
- Einführung von ConsumerWidgets
- Entfernen von Singleton
- Entfernen unnötigen Stateful-Klassen
- Service Injection nutzen für Shared-Preferences
- Migration zu StateNotifierProvider mit simpler Liste als State
- Entfernen von Unmodifiable List
- Wandlung der Filtermethoden hin zu Stateless Utilmethods
- Migration zu einer eigenen immutable State Klasse
- Sublisten/Berechnungsmethoden private setzen
- Sublisten/Berechnungsmethoden in State umwandeln
