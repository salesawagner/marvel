# Marvel
![Swift](https://img.shields.io/badge/Swift-5.0-orange)
![Platforms](https://img.shields.io/badge/Platforms-iOS-yellowgreen)
![Xcode Version](https://img.shields.io/badge/Xcode-15.0-blue)
![Xcode Version](https://img.shields.io/badge/iOS-17.0-blue)


Projeto para avaliação. Lista todos os personagens da marvel com busca por nome. Ao clicar no personagem listado, abre a lista de seus respectivos 'comics'. Ao clicar no 'comic' envia para tela de detalhe do mesmo. Uitilizando a API da marvel ([https://developer.marvel.com](https://developer.marvel.com))

# Requerimentos
XcodeGen ([https://github.com/yonaskolb/XcodeGen](https://github.com/yonaskolb/XcodeGen))</br>
* Utilizei o XcodeGen para evitar conflitos com os arquivos `.xcodeproj`

Cocoapods ([https://cocoapods.org](https://cocoapods.org))</br>
* Utilizado para gerenciamento de dependencias

Swiftlint ([https://github.com/realm/SwiftLint](https://github.com/realm/SwiftLint))

# Start
Ir na pasta `App/` e rodar os comandos no terminal:

```
$  xcodegen generate
$  pod install
```

Abrir o arquivo: `Marvel.xcworkspace`

# Jsons de exemplos
- [CharactersRequest](API/API/Resources/Mocks/GetCharactersRequest.json)
- [GetComicRequest](API/API/Resources/Mocks/GetComicRequest.json)
