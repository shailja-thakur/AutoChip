module top_module (
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    // Define internal signals
    reg [1:0] current_state;
    
    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 2'b01; // Reset to state 1
        else
            current_state <= state; // Keep the current state
    end
    
    // State transition logic
    always @(posedge clk) begin
        if (train_valid) begin
            if (train_taken && (current_state < 2'b11))
                current_state <= current_state + 1; // Transition to next state
            else if (!train_taken && (current_state > 2'b00))
                current_state <= current_state - 1; // Transition to previous state
        end
    end
    
    // Output the current state
    assign state = current_state;
    
endmodule
