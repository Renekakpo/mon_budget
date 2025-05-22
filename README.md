# 📱 Mon Budget - App Flutter

Application mobile de gestion de budget et de dépenses construite avec Flutter, en Clean Architecture, MVVM et structure feature-based.

## 🚀 Fonctionnalités

- 📊 **Tableau de bord** : Graphiques (camembert & barres) des dépenses par catégorie
- 💸 **Dépenses** : Liste, ajout, filtre par période
- 💰 **Revenus** : Liste, ajout, filtre par période
- 🎯 **Budgets** : Création, modification, visualisation par catégorie
- 🗂 **Catégories** : Liste, ajout, suppression conditionnelle
- 💾 Données stockées localement avec **SQLite**

---

## 🧱 Architecture

Structure modulaire et scalable selon **Clean Architecture** avec le pattern **MVVM** :
```
mon_budget/
├── assets/
│   └── icons/         # icônes custom
│   └── images/        # images (si besoin)
├── lib/
│   ├── core/
│   │   ├── constants/       # Constantes globales
│   │   ├── database/        # Base SQLite (helper, schemas)
│   │   ├── errors/          # Exceptions personnalisées
│   │   ├── themes/          # Thème global
│   │   ├── utils/           # Helpers divers (format, date, etc.)
│   │   └── widgets/         # Widgets réutilisables globaux
│   ├── features/
│   │   ├── dashboard/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   └── models/
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   ├── repositories/
│   │   │   │   └── usecases/
│   │   │   ├── presentation/
│   │   │   │   ├── view/
│   │   │   │   └── viewmodel/
│   │   │   └── dashboard_feature.dart
│   │   ├── expenses/
│   │   ├── incomes/
│   │   ├── budgets/
│   │   └── categories/
│   ├── routes/
│   │   └── app_routes.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```

Feature
├── data # Sources de données et modèles DTO
├── domain # Entités, usecases et contrats de repo
├── presentation # UI (view) + logique de présentation (viewmodel)

Les **features** sont isolées (`dashboard`, `expenses`, etc.) et communiquent avec des services partagés via des interfaces.

---

## 🏗 Structure de dossier

📁 `lib/core`  
Contient les classes partagées : thème, exceptions, database helper SQLite, widgets réutilisables.

📁 `lib/features/`  
Chaque fonctionnalité est découpée en `data`, `domain` et `presentation`.

---

## 🧩 Dépendances principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.2.5
  path_provider: ^2.1.2
  provider: ^6.1.1
  intl: ^0.18.1
  fl_chart: ^0.64.0  # pour les graphiques
  uuid: ^4.1.0       # pour générer des IDs

dev_dependencies:
  flutter_test:
    sdk: flutter
```
## ⚙️ Lancement du projet
```bash
Copier
Modifier
flutter pub get
flutter run
```

## 🧪 Potentielles amélioration
- Authentification
- Export CSV / PDF
- Notifications de dépenses
- Support multilingue

## 📦 Livrables attendus
- ✅ Code source complet et structuré
- ✅ README clair
- ✅ Exécutable Flutter fonctionnel
- ✅ Base SQLite intégrée
- ✅ UI ergonomique

## 📚 Licence
- Projet académique - ESGIS Bénin - Master 2 IRT - 2024-2025