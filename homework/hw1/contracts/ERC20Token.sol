// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract CustomERC20 is ERC20, ERC20Permit, Ownable {
    /// Комиссия 5%
    uint256 constant commission = 5;

    /**
     * @notice Конструктор контракта, выпускающий начальное предложение токенов и устанавливающий владельца.
     * @param initialOwner Адрес начального владельца контракта.
     */
    constructor(
        address initialOwner
    )
        ERC20("CustomERC20", "CRC")
        ERC20Permit("CustomERC20")
        Ownable(initialOwner)
    {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    /**
     * @notice Позволяет пользователям покупать токены, отправляя ETH на контракт.
     * @dev Количество отправленных ETH соответствует количеству покупаемых токенов.
     * @dev Требует, чтобы владелец контракта имел достаточное количество токенов для продажи.
     */
    function buyTokens() public payable {
        require(msg.value > 0, "Not valid tokens value");
        require(
            balanceOf(owner()) >= msg.value,
            "Not enough tokens available for sale"
        );

        _transfer(owner(), msg.sender, msg.value);
    }
    /**
     * @notice Переводит токены с комиссией 5% от отправителя к получателю.
     * @param to Адрес получателя токенов.
     * @param value Количество токенов для перевода.
     * @return Возвращает true в случае успешного перевода.
     */
    function transfer(
        address to,
        uint256 value
    ) public override returns (bool) {
        address owner = _msgSender();
        _transferWithComission(owner, to, value);
        return true;
    }

    /**
     * @notice Переводит токены с комиссией 5% от одного адреса к другому, используя разрешение (allowance).
     * @param from Адрес, с которого списываются токены.
     * @param to Адрес получателя токенов.
     * @param value Количество токенов для перевода.
     * @return Возвращает true в случае успешного перевода.
     */
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public override returns (bool) {
        address sender = _msgSender();
        _spendAllowance(from, sender, value);
        _transferWithComission(from, to, value);
        return true;
    }

    /**
     * @dev Выполняет перевод токенов с учетом комиссии.
     * @param from Адрес отправителя токенов.
     * @param to Адрес получателя токенов.
     * @param value Общее количество токенов для перевода (включая комиссию).
     */
    function _transferWithComission(
        address from,
        address to,
        uint256 value
    ) private {
        uint256 comission = getComission(value);
        uint256 amountAfterComission = value - comission;

        _transfer(from, owner(), comission);
        _transfer(from, to, amountAfterComission);
    }

    /**
     * @dev Вычисляет сумму комиссии с указанной суммы.
     * @param amount Общая сумма, с которой вычисляется комиссия.
     * @return Сумма комиссии.
     */
    function getComission(uint256 amount) internal pure returns (uint256) {
        return (amount * commission) / 100;
    }
}
