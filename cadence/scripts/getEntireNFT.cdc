import AttendanceNFT from "../contracts/AttendanceNFT.cdc"
pub fun main(account : Address,id:UInt64): [String?]{
  let publicReference = getAccount(account).getCapability(AttendanceNFT.AttendanceCollectionPublicPath)
                        .borrow<&{AttendanceNFT.CollectionPublic}>()
                        ?? panic("account does not have a collection")

   let details:[String?] = []
  let ref = publicReference.borrowEntireNFT(id: id)


 details.append(ref?.name)
 details.append(ref?.image)
  return details
}
