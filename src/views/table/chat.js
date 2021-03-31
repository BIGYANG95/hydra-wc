const user={
    name:'chat',
    table:{
        ids:'varchar(20) primary key',
        speakUserId: "varchar(20)",
        hearUserId: "varchar(20)",
        text: "varchar(200)",
    }
}

export default user
