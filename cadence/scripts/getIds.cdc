import AttendanceNFT from "../contracts/AttendanceNFT.cdc"

pub fun main(account : Address): [UInt64] {
  let publicReference = getAccount(account).getCapability(AttendanceNFT.AttendanceCollectionPublicPath)
                        .borrow<&{AttendanceNFT.CollectionPublic}>()
                        ?? panic("account does not have a collection")

  return publicReference.getIDs()
}
 