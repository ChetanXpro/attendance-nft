 import NonFungibleToken from "./NonFungibleToken.cdc"

pub contract HolidaysNFT:NonFungibleToken  {
 pub var totalSupply: UInt64
    pub event ContractInitialized()
    pub event Withdraw(id: UInt64, from: Address?)
    pub event Deposit(id: UInt64, to: Address?)



   pub resource NFT:NonFungibleToken.INFT {
        pub let id: UInt64 

        init() {
            self.id = HolidaysNFT.totalSupply
            HolidaysNFT.totalSupply = HolidaysNFT.totalSupply + 1
            }
    }

   
       
        
    pub resource Collection: NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic {
        pub var ownedNFTs: @{UInt64: NonFungibleToken.NFT}

        pub fun withdraw(withdrawID: UInt64): @NonFungibleToken.NFT {
            let token <- self.ownedNFTs.remove(key: withdrawID) ?? panic("This NFT does not exist")
        
            emit Withdraw(id: token.id, from: self.owner?.address)

            return <- token
        }

        pub fun deposit(token: @NonFungibleToken.NFT) {
            let token <- token as! @HolidaysNFT.NFT

            emit Deposit(id: token.id, to: self.owner?.address)

            self.ownedNFTs[token.id] <-! token
        }

        pub fun getIDs(): [UInt64] {
            return self.ownedNFTs.keys
        }

        pub fun borrowNFT(id: UInt64): &NonFungibleToken.NFT {
            let token = &self.ownedNFTs[id] as &NonFungibleToken.NFT
            return token
        }

      

        init() {
            self.ownedNFTs <- {}
        }

        destroy() {
            destroy self.ownedNFTs
        }
    }

      pub fun createEmptyCollection(): @NonFungibleToken.Collection {
        return <- create Collection()
    }

 
    init(){
    self.totalSupply = 0
    }
    
    

}