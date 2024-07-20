module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Registers to hold the current state and next state
    logic [1:0] curr_state, next_state;
    
    // Asynchronous reset
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            curr_state <= 2'b01; // Reset to state 1
        else
            curr_state <= next_state;
    end
    
    // State transition logic
    always_comb
    begin
        case (curr_state)
            2'b00: // state 0
                if (train_valid && train_taken)
                    next_state = 2'b01; // transition to state 1
                else
                    next_state = curr_state; // stay in current state
            2'b01: // state 1
                if (train_valid && train_taken && curr_state < 2'b11)
                    next_state = curr_state + 1'b1; // transition to next state
                else if (train_valid && !train_taken && curr_state > 2'b00)
                    next_state = curr_state - 1'b1; // transition to previous state
                else
                    next_state = curr_state; // stay in current state
            2'b10: // state 2
                // Add state transition logic similar to state 1 if needed
            2'b11: // state 3
                // Add state transition logic similar to state 1 if needed
            default: // should not occur
                next_state = curr_state;
        endcase
    end
    
    // Assign current state to output
    assign state = curr_state;
    
endmodule
