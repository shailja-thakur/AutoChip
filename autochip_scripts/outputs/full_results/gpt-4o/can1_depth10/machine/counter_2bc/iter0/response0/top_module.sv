module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Declare the state register
    logic [1:0] current_state, next_state;
    
    // State machine sequential logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 2'b01; // Reset state to 1
        else if (train_valid)
            current_state <= next_state;
    end
    
    // State machine combinational logic
    always_comb begin
        next_state = current_state; // Default: remain in current state
        if (train_valid) begin
            if (train_taken && current_state < 2'b11)
                next_state = current_state + 2'b01; // Go to next state
            else if (!train_taken && current_state > 2'b00)
                next_state = current_state - 2'b01; // Go to previous state
        end
    end
    
    // Output the current state
    assign state = current_state;
    
endmodule
