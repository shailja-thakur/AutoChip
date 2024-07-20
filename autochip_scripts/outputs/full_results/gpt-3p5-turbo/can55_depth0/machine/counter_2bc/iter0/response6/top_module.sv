module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Define internal signals
    logic [1:0] next_state;
    
    // Define state register
    always_ff @(posedge clk, posedge areset)
    begin
        if (areset)
            state <= 2'b01; // Reset to state 1
        else
            state <= next_state; // Update state based on next_state
    end
    
    // Define next state logic
    always_comb
    begin
        case (state)
            2'b00: // State 0
                begin
                    if (train_valid && train_taken)
                        next_state = 2'b01; // Transition to state 1
                    else
                        next_state = state; // Stay in current state
                end
            2'b01: // State 1
                begin
                    if (train_valid && train_taken)
                        next_state = 2'b10; // Transition to state 2
                    else if (!train_taken && state > 2'b00)
                        next_state = 2'b00; // Transition to state 0
                    else
                        next_state = state; // Stay in current state
                end
            2'b10: // State 2
                begin
                    if (train_valid && train_taken)
                        next_state = 2'b11; // Transition to state 3
                    else if (!train_taken && state > 2'b01)
                        next_state = 2'b01; // Transition to state 1
                    else
                        next_state = state; // Stay in current state
                end
            2'b11: // State 3
                begin
                    if (!train_taken && state > 2'b10)
                        next_state = 2'b10; // Transition to state 2
                    else
                        next_state = state; // Stay in current state
                end
        endcase
    end
endmodule
