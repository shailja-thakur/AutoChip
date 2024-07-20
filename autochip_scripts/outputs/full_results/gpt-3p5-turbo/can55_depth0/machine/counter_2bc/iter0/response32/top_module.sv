module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State register
    logic [1:0] current_state;
    
    // Next state logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01; // Reset state to 1
        end
        else begin
            case (current_state)
                2'b00: begin
                    // State 0 logic
                    if (train_taken && current_state < 2'b11) begin
                        current_state <= current_state + 1; // Transition to next state
                    end
                    else if (!train_taken && current_state > 2'b00) begin
                        current_state <= current_state - 1; // Transition to previous state
                    end
                    else begin
                        current_state <= current_state; // Remain in current state
                    end
                end
                2'b01: begin
                    // State 1 logic
                    if (train_valid) begin
                        current_state <= 2'b10; // Transition to state 2
                    end
                    else begin
                        current_state <= current_state; // Remain in current state
                    end
                end
                2'b10: begin
                    // State 2 logic
                    if (train_taken && current_state < 2'b11) begin
                        current_state <= current_state + 1; // Transition to next state
                    end
                    else if (!train_taken && current_state > 2'b00) begin
                        current_state <= current_state - 1; // Transition to previous state
                    end
                    else begin
                        current_state <= current_state; // Remain in current state
                    end
                end
                2'b11: begin
                    // State 3 logic
                    if (train_valid) begin
                        current_state <= 2'b10; // Transition to state 2
                    end
                    else begin
                        current_state <= current_state; // Remain in current state
                    end
                end
            endcase
        end
    end
    
    // Output assignment
    assign state = current_state;

endmodule
