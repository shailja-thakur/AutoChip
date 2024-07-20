module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Declare internal signals
    logic [1:0] next_state;
    
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'b01; // Reset to state 1
        else if (train_valid)
        begin
            case(state)
                2'b00: // State 0
                    if (train_taken)
                        next_state = 2'b01; // Transition to state 1 if train_taken is asserted
                    else
                        next_state = 2'b00; // Remain in state 0 if train_taken is not asserted
                2'b01: // State 1
                    if (train_taken)
                        next_state = 2'b10; // Transition to state 2 if train_taken is asserted
                    else
                        next_state = 2'b00; // Transition to state 0 if train_taken is not asserted
                2'b10: // State 2
                    if (train_taken)
                        next_state = 2'b11; // Transition to state 3 if train_taken is asserted
                    else
                        next_state = 2'b01; // Transition to state 1 if train_taken is not asserted
                2'b11: // State 3
                    if (train_taken)
                        next_state = 2'b11; // Remain in state 3 if train_taken is asserted
                    else
                        next_state = 2'b10; // Transition to state 2 if train_taken is not asserted
            endcase
            state <= next_state; // Update current state with next_state
        end
    end
endmodule
