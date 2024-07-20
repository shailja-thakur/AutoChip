module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Declare internal state register
    logic [1:0] current_state, next_state;
    
    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01; // Reset to state 1
        end
        else if (train_valid) begin
            current_state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        next_state = current_state; // Default is to stay in the current state
        if (train_valid) begin
            if (train_taken) begin
                if (current_state < 2'b11) begin
                    next_state = current_state + 2'b01; // Move to next state
                end
            end
            else begin
                if (current_state > 2'b00) begin
                    next_state = current_state - 2'b01; // Move to previous state
                end
            end
        end
    end
    
    // Output assignment
    assign state = current_state;

endmodule
