// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CustomERC1155 is ERC1155, Ownable {
    /**
     * @notice Конструктор контракта, инициализирующий ERC1155 токен с базовым URI и устанавливающий владельца.
     * @param initialOwner Адрес начального владельца контракта.
     */
    constructor(
        address initialOwner
    )
        ERC1155(
            "https://opensea.io/assets/ethereum/0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d/"
        )
        Ownable(initialOwner)
    {}

    /**
     * @notice Устанавливает новый URI для всех типов токенов.
     * @dev Только владелец контракта может вызывать эту функцию.
     * @param newuri Новый URI в виде строки.
     */
    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    /**
     * @notice Выпускает (минтит) указанное количество токенов определенного ID и передает их на указанный адрес.
     * @dev Только владелец контракта может вызывать эту функцию.
     * @param account Адрес, на который будут выпущены токены.
     * @param id ID токена, который нужно выпустить.
     * @param amount Количество токенов для выпуска.
     * @param data Дополнительные данные, не имеющие определенного формата, отправляемые в вызов `onERC1155Received` на `account`.
     */
    function mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(account, id, amount, data);
    }
}
