module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] current_state;

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset)
    begin
        if (areset)
            current_state <= 2'b01;  // Reset to state 1
        else
        begin
            // State transitions
            case(current_state)
                2'b00:
                    if (train_valid && train_taken)
                        current_state <= 2'b01;  // Transition to state 1
                    else
                        current_state <= 2'b00;  // Remain in state 0
                2'b01:
                    if (train_valid && train_taken)
                        current_state <= 2'b10;  // Transition to state 2
                    else
                        current_state <= 2'b00;  // Transition to state 0
                2'b10:
                    if (train_valid && !train_taken)
                        current_state <= 2'b01;  // Transition to state 1
                    else if (train_valid && train_taken)
                        current_state <= 2'b11;  // Transition to state 3
                    else
                        current_state <= 2'b10;  // Remain in state 2
                2'b11:
                    if (train_valid && !train_taken)
                        current_state <= 2'b10;  // Transition to state 2
                    else
                        current_state <= 2'b11;  // Remain in state 3
                default:
                    current_state <= 2'b00;  // Default to state 0
            endcase
        end
    end
    
    // Output assignment
    assign state = current_state;

endmodule
