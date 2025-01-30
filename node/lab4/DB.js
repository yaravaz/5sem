EventEmitter = require('events');

class DB extends EventEmitter{

    database = [];

    async select() {
        return new Promise((res, rej) => {
            res(this.database);
        });
    }

    async insert(consumer){
        return new Promise((res, rej) => {
            let consumerID = this.database.findIndex(cs => cs.id == consumer.id);
            if(consumerID === -1){
                this.database.push(consumer);
                res(consumer);
            }
            else{
                rej({error: "Человек с id: " + consumer.id + " уже существует"});
            }
        })
    }

    async update(consumer){
        return new Promise((res, rej) => {
            let consumerID = this.database.findIndex(cs => cs.id == consumer.id);
            if(consumerID !== -1){
                this.database[consumerID] = consumer;
                res(consumer);
            }
            else{
                rej({error: "Человека с id: " + consumer.id + " не существует"});
            }
        })
    }

    async delete(id){
        return new Promise((res, rej) => {
            let consumerID = this.database.findIndex(cs => cs.id == id);
            if(consumerID !== -1){
                this.database.splice(consumerID, 1);
                res(id);
            }
            else{
                rej({error: "Человека с id: " + id + " не существует"});
            }
        })
    }
}

module.exports.DB = DB;