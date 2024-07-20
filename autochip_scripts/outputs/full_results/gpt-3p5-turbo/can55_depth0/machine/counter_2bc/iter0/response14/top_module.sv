module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define state variables
    logic [1:0] current_state;
    logic [1:0] next_state;

    // Synchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 2'b01; // Reset to state 1
        else
            current_state <= next_state;
    end

    // State transitions
    always_comb begin
        case (current_state)
            2'b00: begin // State 0
                if (train_valid && train_taken)
                    next_state = 2'b01; // Transition to state 1
                else if (train_valid && !train_taken)
                    next_state = 2'b11; // Transition to state 3
                else
                    next_state = current_state;
            end

            2'b01: begin // State 1
                if (train_valid && train_taken)
                    next_state = 2'b10; // Transition to state 2
                else if (train_valid && !train_taken)
                    next_state = current_state; // Remain in state 1
                else
                    next_state = 2'b00; // Transition to state 0
            end

            2'b10: begin // State 2
                if (train_valid && train_taken)
                    next_state = 2'b11; // Transition to state 3
                else if (train_valid && !train_taken)
                    next_state = 2'b01; // Transition to state 1
                else
                    next_state = 2'b00; // Transition to state 0
            end

            2'b11: begin // State 3
                if (train_valid && train_taken)
                    next_state = current_state; // Remain in state 3
                else if (train_valid && !train_taken)
                    next_state = 2'b10; // Transition to state 2
                else
                    next_state = 2'b01; // Transition to state 1
            end
        endcase
        state = current_state;
    end
endmodule
