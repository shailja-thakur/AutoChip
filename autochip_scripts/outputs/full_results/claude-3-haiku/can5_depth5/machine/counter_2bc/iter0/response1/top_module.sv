module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_ff @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01; // Reset to state 1
    else
        state <= next_state;
end

always_comb begin
    next_state = state; // Default: stay in current state
    case (state)
        2'b00: begin // State 0
            if (train_valid && train_taken)
                next_state = 2'b01; // Transition to state 1
        end
        2'b01: begin // State 1
            if (train_valid && train_taken)
                next_state = 2'b10; // Transition to state 2
            else if (train_valid && !train_taken)
                next_state = 2'b00; // Transition to state 0
        end
        2'b10: begin // State 2
            if (train_valid && train_taken)
                next_state = 2'b11; // Transition to state 3
            else if (train_valid && !train_taken)
                next_state = 2'b01; // Transition to state 1
        end
        2'b11: begin // State 3
            if (train_valid && !train_taken)
                next_state = 2'b10; // Transition to state 2
        end
    endcase
end

endmodule
