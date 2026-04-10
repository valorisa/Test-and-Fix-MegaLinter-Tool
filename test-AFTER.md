<?xml version="1.0" encoding="UTF-8"?>
<project>
  <name>MegaLinter Setup</name>
  <version>1.0.0</version>
  <description>Outils de linting automatisé pour projets hybrides XML/Markdown</description>

  <!-- Documentation du projet -->
  <documentation>
    <section id="intro">
      <title>Introduction</title>
      <content>
        Ce projet a pour objectif de mettre en place un environnement de linting et de formatting automatisé pour les fichiers Markdown et autres types de fichiers, en utilisant MegaLinter.
      </content>
    </section>

    <section id="pourquoi">
      <title>Pourquoi MegaLinter ?</title>
      <content>
        MegaLinter est un outil puissant qui permet de :
        - **Automatiser** le processus de vérification du code
        - **Standardiser** les règles de linting across plusieurs langages
        - **Intégrer** facilement dans les workflows CI/CD
        - **Fournir des rapports détaillés** sur les problèmes détectés
      </content>
    </section>
  </documentation>

  <!-- Installation guide -->
  <installation>
    <method name="docker">
      <code>docker run -v $(pwd):/workspace ramonearte/megalinter:latest</code>
      <note>Cette méthode est recommandée pour les environnements de production</note>
    </method>
    <method name="npm">
      <code>npm install -g megalinter</code>
    </method>
    <method name="pip">
      <code>pip install megalinter</code>
    </method>
  </installation>

  <!-- Configuration -->
  <configuration>
    <file name=".mega-linter.yml">
      <content>
ENABLE:
  - MARKDOWN
  - YAML
  - JSON
  - XML

MARKDOWN_CONFIG_FILE:
- .markdownlint.json
      </content>
    </file>
  </configuration>

  <!-- Exemples de problèmes -->
  <examples>
    <problem id="1">
      <type>Ligne trop longue</type>
      <description>Voici une ligne qui dépasse largement les 80 caractères recommandés et qui devrait être détectée par le linter comme étant trop longue pour être affichée correctement dans un terminal standard sans wrap.</description>
    </problem>

    <problem id="2">
      <type>Trailing whitespace</type>
      <description>Cette ligne contient des espaces à la fin qui ne devraient pas être là.   </description>
    </problem>

    <problem id="3">
      <type>Tableau mal formaté</type>
      <content>
| Colonne 1 | Colonne 2 | Colonne 3 |
|-----------|-----------|-----------|
| Valeur 1  | Valeur 2  | Valeur 3  |
| Valeur 4  | Valeur 5  | Valeur 6  |
      </content>
    </problem>

    <problem id="4">
      <type>Header sans espace</type>
      <content>
# HeaderSansEspace

---

## Sous-section

### Encore un header

#### Header niveau 4
      </content>
    </problem>
  </examples>

  <!-- Code blocks -->
  <code_examples>
    <example lang="powershell">
Describe "MegaLinter Integration" {
    It "Should detect markdown issues" {
        $result = Invoke-MegaLinter -Path "test.md"
        $result.Issues | Should -Not -BeNullOrEmpty
    }
    It "Should fix trailing whitespace" {
        $content = "Line with spaces   "
        $fixed = Fix-TrailingWhitespace -Content $content
        $fixed | Should -Not -Match "\s+$"
    }
}
    </example>

    <example lang="bash">
# !/bin/bash
echo "MegaLinter test"
megalinter --path "src/**/*.md"
megalinter -v
    </example>
  </code_examples>

  <!-- Troubleshooting -->
  <troubleshooting>
    <issue>
      <error>"MegaLinter not found"</error>
      <solution>Vérifiez que MegaLinter est bien installé avec megalinter --version</solution>
    </issue>
    <issue>
      <error>"Permission denied"</error>
      <solution>Ajoutez les droits d'exécution: chmod +x megalinter.sh</solution>
    </issue>
    <issue>
      <error>"Docker container cannot start"</error>
      <solution>Vérifiez que Docker est bien lancé: docker ps</solution>
    </issue>
  </troubleshooting>
</project>

---

# Tests Automatisés

Pour vérifier que MegaLinter fonctionne correctement, nous avons mis en place des tests avec Pester :

```powershell
Describe "MegaLinter Integration" {
    It "Should detect markdown issues" {
        $result = Invoke-MegaLinter -Path "test.md"
        $result.Issues | Should -Not -BeNullOrEmpty
    }
    
    It "Should fix trailing whitespace" {
        $content = "Line with spaces   "
        $fixed = Fix-TrailingWhitespace -Content $content
        $fixed | Should -Not -Match "\s+$"
    }
}
```

## Bonnes Pratiques

1. **Lancez MegaLinter localement** avant de commiter
2. **Configurez des pre-commit hooks** pour automatiser le linting
3. **Fixez les erreurs progressivement** ne pas tout changer d'un coup
4. **Documentez vos exceptions** si vous devez ignorer une règle
5. **Gardez la config simple** au départ puis affinez progressivement

## Roadmap

- [ ] Ajouter plus de linters
- [ ] Améliorer la performance
- [ ] Créer un GUI
- [ ] Intégrer avec plus de CI/CD

## Contributeurs

Merci à tous les contributeurs qui ont aidé à améliorer ce projet !

## Licence

MIT License - Voir le fichier LICENSE pour plus de détails.

## Références

- Site officiel : <https://oxsecurity.github.io/megalinter/>
- GitHub : <https://github.com/oxsecurity/megalinter>
- Documentation : <https://megalinter.io/>