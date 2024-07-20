module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Declare internal signal and temporary variable to hold the next state
    logic [1:0] next_state;

    // Implement asynchronous reset
    always_ff @(posedge clk, posedge areset)
    begin
        if (areset)
            state <= 2'b01; // Reset state to 01 when areset is asserted
        else
            state <= next_state; // Continue with next state otherwise
    end

    // Determine the next state based on the inputs and current state
    always_comb
    begin
        next_state = state;

        if (train_valid)
        begin
            if (train_taken && state < 2'b11) // Transition to the next state if train_taken is asserted and current state is less than 11
                next_state = state + 1;
            else if (!train_taken && state > 2'b00) // Transition to the previous state if train_taken is not asserted and current state is greater than 00
                next_state = state - 1;
        end
    end

endmodule
