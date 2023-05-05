pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GenerativeArtworkNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct GenerativeArtwork {
        uint256 id;
        string title;
        address creativeCoder;
        uint256 royaltyPercentage;
    }

    mapping(uint256 => GenerativeArtwork) private _artworks;

    event ArtworkTokenized(uint256 tokenId, string title, address creativeCoder);

    constructor() ERC721("GeneratedArt", "GART") {}

    function tokenizeArtwork(
        address creativeCoder,
        string memory title,
        uint256 royaltyPercentage
    ) public returns (uint256) {
        require(royaltyPercentage > 0 && royaltyPercentage <= 100, "Invalid royalty percentage");
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(creativeCoder, newItemId);

        _artworks[newItemId] = GenerativeArtwork({
            id: newItemId,
            title: title,
            creativeCoder: creativeCoder,
            royaltyPercentage: royaltyPercentage
        });

        emit ArtworkTokenized(newItemId, title, creativeCoder);

        return newItemId;
    }

    function getGenerativeArtwork(uint256 tokenId) public view returns (GenerativeArtwork memory) {
        return _artworks[tokenId];
    }

    // Implement custom licensing, distribution of proceeds, and other functionality here
}
