// the minimum DNA of an Adventurer
use starknet::ContractAddress;


const GAMEKEY: felt252 = 'Adventurer';
// record the auto-increment id 
#[derive(Model, Copy, Drop, Serde)]
struct GameData {
    #[key]
    key: felt252,
    adventurer_id: u128,
}


// ID is a unique identifier for an entity
#[derive(Model, Copy, Drop, Serde)]
struct AdventurerId {
    #[key]
    player: ContractAddress,
    adventurer_id: u128,
//
// think about the situation where player has a few adventurers
// model can't store array yet, so hard code
// second: u64,
// third: u64,
//
}

#[derive(Model, Copy, Drop, Serde)]
struct PlayerAddress {
    #[key]
    adventurer_id: u128,
    player: ContractAddress,
}

// Name is a component that can be attached to an entity 
#[derive(Model, Copy, Drop, Serde)]
struct Name {
    #[key]
    adventurer_id: u128,
    name: felt252,
}


// ID is a unique identifier for an entity
#[derive(Model, Copy, Drop, Serde)]
struct Energy {
    #[key]
    adventurer_id: u128,
    value: u64,
}

// Health is a component that can be attached to an entity
#[derive(Model, Copy, Drop, Serde, SerdeLen)]
struct Health {
    #[key]
    adventurer_id: u128,
    health: u32,
}


// This can be inherited from the World, but leaving here for testing
#[derive(Model, Copy, Drop, Serde)]
struct Position {
    #[key]
    adventurer_id: u128,
    // which map is this adventurer in
    location: u128,
    // where is this adventurer in the map
    vec: Vec3,
}

#[derive(Copy, Drop, Serde, Introspect)]
struct Vec3 {
    x: u32,
    y: u32,
    // in case of 3d
    z: u32
}
