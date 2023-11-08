// the minimum DNA of an Adventurer

#[derive(Copy, Drop, Serde, Introspect)]
struct Vec2 {
    x: u32,
    y: u32
}

// Health is a component that can be attached to an entity
#[derive(Model, Copy, Drop, Serde, SerdeLen)]
struct Health {
    #[key]
    entity_id: u64,
    health: u32,
}

// This can be inherited from the World, but leaving here for testing
#[derive(Model, Copy, Drop, Serde)]
struct Position {
    #[key]
    entity_id: u64,
    vec: Vec2,
}

// ID is a unique identifier for an entity
#[derive(Model, Copy, Drop, Serde)]
struct AdventurerId {
    #[key]
    entity_id: u64,
    id: u64,
}

// ID is a unique identifier for an entity
#[derive(Model, Copy, Drop, Serde)]
struct Energy {
    #[key]
    entity_id: u64,
    value: u64,
}
