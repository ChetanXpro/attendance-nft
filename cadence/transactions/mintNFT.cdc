import AttendanceNFT from "../contracts/AttendanceNFT.cdc"

transaction(image:String,name:String){


    prepare(auth:AuthAccount){
   let col = auth.borrow<&AttendanceNFT.Collection>(from:AttendanceNFT.AttendanceCollectionStoragePath )
    col?.deposit(token: <- AttendanceNFT.mintNFT(image:image , name: name))
  
    }
}