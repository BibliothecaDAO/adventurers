use realms_adventurers::models::dna::{Vec3};
use starknet::ContractAddress;

#[starknet::interface]
trait IDNA<TContractState> {
    fn spawn(self: @TContractState, location: u128, vec: Vec3, name: felt252);
    fn move(self: @TContractState, location: u128, adventurer_id: u128);
    fn get_adventurer(self: @TContractState, player: ContractAddress) -> u128;
}

mod error {
    const AdventurerAlreadyExists: felt252 = 'adventurer already exists';
}

#[dojo::contract]
mod spawn {
    use super::{IDNA, error};
    use realms_adventurers::models::dna::{
        GameData, GAMEKEY, AdventurerId, PlayerAddress, Name, Energy, Health, Position, Vec3
    };
    use starknet::{ContractAddress, get_caller_address};

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Spawn: Spawn
    }

    #[derive(Drop, starknet::Event)]
    struct Spawn {
        #[key]
        player: ContractAddress,
        #[key]
        adventurer_id: u128
    }

    // #[generate_trait]
    // impl InternalImpl of InternalTrait<ContractState> {}

    #[external(v0)]
    fn test(self: @ContractState) {
        // let world = self.world_dispatcher.read();
        // let input: felt252 = get_caller_address().into();
        // world.delete_entity('AdventurerId', array![input].span());

        DNAImpl::spawn(self, 1, Vec3 { x: 0, y: 0, z: 0 }, '1');
    }

    #[external(v0)]
    impl DNAImpl of IDNA<ContractState> {
        //
        fn spawn(self: @ContractState, location: u128, vec: Vec3, name: felt252) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();

            assert(
                get!(world, player, (AdventurerId)).adventurer_id == 0,
                error::AdventurerAlreadyExists
            );

            let adventurer_id = get!(world, GAMEKEY, (GameData)).adventurer_id + 1;

            set!(
                world,
                (
                    GameData { game: GAMEKEY, adventurer_id: adventurer_id },
                    AdventurerId { player: player, adventurer_id: adventurer_id },
                    PlayerAddress { adventurer_id: adventurer_id, player: player },
                    Name { adventurer_id: adventurer_id, name: name },
                    Energy { adventurer_id: adventurer_id, value: 100 },
                    Health { adventurer_id: adventurer_id, health: 100 },
                    Position {
                        adventurer_id: adventurer_id,
                        location: location,
                        vec: Vec3 { x: vec.x, y: vec.y, z: vec.z }
                    },
                )
            );

            // emit events
            emit!(world, Spawn { player: player, adventurer_id: adventurer_id });
        }

        fn move(self: @ContractState, location: u128, adventurer_id: u128) {}

        fn get_adventurer(self: @ContractState, player: ContractAddress) -> u128 {
            0
        }
    }
}

