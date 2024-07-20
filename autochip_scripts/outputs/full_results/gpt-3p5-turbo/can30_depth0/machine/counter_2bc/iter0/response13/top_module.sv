module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    logic [1:0] next_state;

    // State machine process
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state 1
            state <= 2'b01;
        end else if (train_valid) begin
            if (train_taken && (state < 2'b11)) begin
                // Transition to next state if train_taken is asserted and state is less than 3
                next_state <= state + 1;
            end else if (!train_taken && (state > 2'b00)) begin
                // Transition to previous state if train_taken is not asserted and state is greater than 0
                next_state <= state - 1;
            end else begin
                // Remain in current state
                next_state <= state;
            end
        end else begin
            // Remain in current state
            next_state <= state;
        end
    end

    // Assign next state to current state
    always_comb begin
        state <= next_state;
    end

endmodule
