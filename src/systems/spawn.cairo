use realms_adventurers::models::dna;
use starknet::ContractAddress;

#[starknet::interface]
trait IDNA<TContractState> {
    fn spawn(self: @TContractState, location: u128, vec: dna::Vec3, name: felt252);
    fn move(self: @TContractState, location: u128, adventurer_id: u128);
    fn get_adventurer(self: @TContractState, player: ContractAddress) -> u128;
}

mod error {
    const AdventurerAlreadyExists: felt252 = 'adventurer already exists';
}

#[dojo::contract]
mod spawn {
    use super::{IDNA, error};
    use realms_adventurers::models::dna;
    use starknet::{ContractAddress, get_caller_address};

    // #[generate_trait]
    // impl InternalImpl of InternalTrait<ContractState> {}

    // #[external(v0)]
    impl DNAImpl of IDNA<ContractState> {
        //
        fn spawn(self: @ContractState, location: u128, vec: dna::Vec3, name: felt252) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();

            assert(
                get!(world, player, (dna::AdventurerId)) == 0,
                error::AdventurerAlreadyExists
            );

            let adventurer_id = get!(world, dna::GAMEKEY, (dna::GameData)) + 1;

            set!(
                world,
                (
                    dna::GameData { key: dna::GAMEKEY, adventurer_id: adventurer_id },
                    dna::AdventurerId { player: player, adventurer_id: adventurer_id },
                    dna::PlayerAddress { adventurer_id: adventurer_id, player: player },
                    dna::Name { adventurer_id: adventurer_id, name: name },
                    dna::Energy { adventurer_id: adventurer_id, value: 100 },
                    dna::Health { adventurer_id: adventurer_id, health: 100 },
                    dna::Position {
                        adventurer_id: adventurer_id,
                        location: location,
                        vec: dna::Vec3 { x: vec.x, y: vec.y, z: vec.z }
                    },
                )
            );
        // emit events
        }

        fn move(self: @ContractState, location: u128, adventurer_id: u128) {}

        fn get_adventurer(self: @ContractState, player: ContractAddress) -> u128 {
            0
        }
    }
}

