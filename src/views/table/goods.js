const user={
    name:'goods',
    table:{
        ids:'varchar(20) primary key',
        names:'varchar(20) not null',
        price:'varchar(200) not null',
        sortId:'varchar(200) not null',
        hot:'varchar(200)',
        shopId:'varchar(200)',
        userId:'varchar(200)',
        sales:'varchar(200)', // 销量
    }
}

export default user
