// the minimum DNA of an Adventurer

use starknet::ContractAddress;

// ID is a unique identifier for an entity
#[derive(Model, Copy, Drop, Serde)]
struct AdventurerId {
    #[key]
    player: ContractAddress,
    adventurer_id: u64,
//
// think about the situation where player has a few adventurers
// model can't store array yet, so hard code
// second: u64,
// third: u64,
//
}

#[derive(Model, Copy, Drop, Serde)]
struct playerAddress {
    #[key]
    adventurer_id: u64,
    player: ContractAddress,
}

// Name is a component that can be attached to an entity 
#[derive(Model, Copy, Drop, Serde)]
struct Name {
    #[key]
    adventurer_id: u64,
    name: felt252,
}


// ID is a unique identifier for an entity
#[derive(Model, Copy, Drop, Serde)]
struct Energy {
    #[key]
    adventurer_id: u64,
    value: u64,
}

// Health is a component that can be attached to an entity
#[derive(Model, Copy, Drop, Serde, SerdeLen)]
struct Health {
    #[key]
    adventurer_id: u64,
    health: u32,
}


// This can be inherited from the World, but leaving here for testing
#[derive(Model, Copy, Drop, Serde)]
struct Position {
    #[key]
    adventurer_id: u64,
    vec: Vec2,
}

#[derive(Copy, Drop, Serde, Introspect)]
struct Vec2 {
    x: u32,
    y: u32
}
