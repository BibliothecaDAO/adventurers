#[starknet::interface]
trait IDNA<TContractState> {
    fn spawn(self: @TContractState, location: u64);
    fn move(self: @TContractState, adventurer_id: u64);
    fn get_adventurer(self: @TContractState, adventurer_id: u64) -> u64;
}

#[dojo::contract]
mod spawn {}
