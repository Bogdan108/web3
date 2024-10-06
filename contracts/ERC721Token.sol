// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CustomERC721 is ERC721, Ownable {
    /// @notice Хранит базовый URI для всех токенов
    string private _baseTokenURI;

    /**
     * @notice Конструктор контракта, устанавливающий имя и символ токена, а также владельца контракта.
     * @param initialOwner Адрес начального владельца контракта.
     */
    constructor(
        address initialOwner
    ) ERC721("CustomERC721", "CERC") Ownable(initialOwner) {}

    /**
     * @notice Устанавливает базовый URI для всех токенов.
     * @dev Только владелец контракта может вызывать эту функцию.
     * @param baseUri Новый базовый URI.
     */
    function setBaseURI(string memory baseUri) external onlyOwner {
        _baseTokenURI = baseUri;
    }

    /**
     * @notice Возвращает базовый URI для вычисления {tokenURI}.
     * @dev Переопределяет функцию {_baseURI} из ERC721.
     * @return Базовый URI в виде строки.
     */
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    /**
     * @notice Безопасно выпускает (минтит) новый токен и передает его указанному адресу.
     * @dev Только владелец контракта может вызывать эту функцию.
     * @param to Адрес получателя нового токена.
     * @param tokenId Идентификатор нового токена.
     */
    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }
}
