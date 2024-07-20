module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Define the state signals
    logic [1:0] current_state;
    
    // Clock edge detection
    always_ff @(posedge clk or negedge areset) begin
        if (areset)
            current_state <= 2'b01; // Reset to state 1
        else if (train_valid) begin
            if (train_taken && current_state < 2'b11)
                current_state <= current_state + 1; // Transition to next state
            else if (!train_taken && current_state > 2'b00)
                current_state <= current_state - 1; // Transition to previous state
        end
    end
    
    // Assign the state signal
    assign state = current_state;
    
endmodule
