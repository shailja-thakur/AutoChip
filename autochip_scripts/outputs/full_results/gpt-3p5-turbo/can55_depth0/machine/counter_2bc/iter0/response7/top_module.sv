module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Internal signal to hold the current state
    logic [1:0] current_state;
    
    // State machine logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset state machine to state 1
            current_state <= 2'b01;
        end else if (train_valid) begin
            if (train_taken && current_state < 2'b11) begin
                // Transition to next state if taken signal is asserted and current state is less than 3
                current_state <= current_state + 1;
            end else if (!train_taken && current_state > 2'b00) begin
                // Transition to previous state if taken signal is not asserted and current state is greater than 0
                current_state <= current_state - 1;
            end
            // Remain in current state if none of the above conditions are met
        end
    end
    
    // Output
    assign state = current_state;
    
endmodule
