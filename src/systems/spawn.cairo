use realms_adventurers::models::dna;

#[starknet::interface]
trait IDNA<TContractState> {
    fn spawn(self: @TContractState, location: u128, vec: dna::Vec3);
    fn move(self: @TContractState, location: u128, adventurer_id: u64);
    fn get_adventurer(self: @TContractState, adventurer_id: u64) -> u64;
}

#[dojo::contract]
mod spawn {
    use super::IDNA;
    use realms_adventurers::models::dna;

    // #[generate_trait]
    // impl InternalImpl of InternalTrait<ContractState> {}

    // #[external(v0)]
    impl DNAImpl of IDNA<ContractState> {
        fn spawn(self: @ContractState, location: u128, vec: dna::Vec3) {}
        fn move(self: @ContractState, location: u128, adventurer_id: u64) {}
        fn get_adventurer(self: @ContractState, adventurer_id: u64) -> u64 {
            0
        }
    }
}
