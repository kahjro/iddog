# iddog
Desafio iOS da idwall<br>
[**Desafio idwall**](https://github.com/idwall/desafios-iddog)

# Requisitos
* Xcode 11.3.1
* Swift 5.0
* iOS 9.0
* [**Cocoapods**](https://cocoapods.org/)

# Instruções de execução 
1. Clone esse repositório
2. Execute um `pod install`
3. Abra o arquivo `iddog.xcworkspace`

# Bibliotecas 
[**SDWebImage**](https://github.com/SDWebImage/SDWebImage): Usado para fazer o download e cache das imagens

[**KIF**](https://github.com/kif-framework/KIF): Usado nos testes para realizar interações na interface, assim podendo cobrir mais cenários de teste

[**KeychainSwift**](https://github.com/evgenyneu/keychain-swift): Usado para persistir dados sensíveis

[**Alamofire**](https://github.com/Alamofire/Alamofire): Usado para realizar os requests e tratamentos de retorno das APIs

# Arquitetura
Para esse projeto, a arquitetura escolhida foi a `Clean` pois facilita a separação de responsabilidades da ViewController, além de facilitar na execução e mock de testes de cada camada

# Pontos fortes
* [x] Viewcode
* [x] Uso de principios SOLID
* [x] Testes com fácil legibilidade

# Melhorias
* [ ] Criar um ambiente de mock para realizar a execução do app offline
* [ ] Suportar darkmode
