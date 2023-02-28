import AttendanceNFT from "../contracts/AttendanceNFT.cdc"


transaction(){


    prepare(auth:AuthAccount){
      if auth.borrow<&AttendanceNFT.Collection>(from: AttendanceNFT.AttendanceCollectionStoragePath) == nil {
        auth.save(<- AttendanceNFT.createEmptyCollection() , to: AttendanceNFT.AttendanceCollectionStoragePath)
        auth.link<&{AttendanceNFT.CollectionPublic}>(AttendanceNFT.AttendanceCollectionPublicPath , target: AttendanceNFT.AttendanceCollectionStoragePath)
      }
    }
}