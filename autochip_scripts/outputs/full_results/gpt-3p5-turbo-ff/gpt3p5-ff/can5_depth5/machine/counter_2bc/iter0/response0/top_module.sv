module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Registers to hold the current state and next state
    logic [1:0] curr_state, next_state;
    
    // Reset the state machine to state 1 when reset signal is asserted
    always_ff @(posedge clk, posedge areset)
    begin
        if (areset)
            curr_state <= 2'b01;
        else
            curr_state <= next_state;
    end
    
    // State machine transitions based on the valid and taken signals
    always_comb
    begin
        case(curr_state)
            
            // State 0
            2'b00:
                begin
                    if (train_valid)
                    begin
                        if (train_taken)
                            next_state = 2'b01;  // Transition to state 1
                        else
                            next_state = 2'b00;  // Stay in state 0
                    end
                    else
                        next_state = 2'b00;  // Stay in state 0
                end
            
            // State 1
            2'b01:
                begin
                    if (train_valid)
                    begin
                        if (train_taken)
                            next_state = 2'b10;  // Transition to state 2
                        else
                            next_state = 2'b00;  // Transition to state 0
                    end
                    else
                        next_state = 2'b01;  // Stay in state 1
                end
            
            // State 2
            2'b10:
                begin
                    if (train_valid)
                    begin
                        if (train_taken)
                            next_state = 2'b11;  // Transition to state 3
                        else
                            next_state = 2'b01;  // Transition to state 1
                    end
                    else
                        next_state = 2'b10;  // Stay in state 2
                end
            
            // State 3
            2'b11:
                begin
                    if (train_valid)
                        next_state = 2'b10;  // Transition to state 2
                    else
                        next_state = 2'b11;  // Stay in state 3
                end
                
        endcase
    end
    
    // Assign the current state to output
    assign state = curr_state;
    
endmodule
