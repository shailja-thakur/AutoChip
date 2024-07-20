module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State registers
    logic [1:0] current_state;
    logic [1:0] next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 2'b01;  // Reset to state 1
        else begin
            // Determine next state based on current state and input signals
            case (current_state)
                2'b00:  // State 0
                    if (train_valid && train_taken)
                        next_state <= 2'b01;  // Transition to state 1
                    else
                        next_state <= 2'b00;  // Remain in state 0
                2'b01:  // State 1
                    if (train_valid && train_taken)
                        next_state <= 2'b10;  // Transition to state 2
                    else
                        next_state <= 2'b00;  // Transition to state 0
                2'b10:  // State 2
                    if (train_valid && train_taken)
                        next_state <= 2'b11;  // Transition to state 3
                    else
                        next_state <= 2'b01;  // Transition to state 1
                2'b11:  // State 3
                    if (train_valid && !train_taken)
                        next_state <= 2'b10;  // Transition to state 2
                    else
                        next_state <= 2'b11;  // Remain in state 3
            endcase
        end
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01;  // Reset to state 1
        else
            state <= next_state;  // Update state register
    end

endmodule
