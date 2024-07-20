module top_module(
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);
    
    // Internal signals
    logic [1:0] next_state;
    
    // State register
    always_ff @(posedge clk or negedge areset) begin
        if (areset == 0) begin
            state <= 2'b01;  // Reset to state 1
        end else begin
            state <= next_state;  // Update state based on next_state
        end
    end
    
    // Next state logic
    always_comb begin
        if (train_valid == 1) begin
            if (train_taken == 1 && state < 2'b11) begin
                next_state = state + 2'b01;  // Transition to the next state
            end else if (train_taken == 0 && state > 2'b00) begin
                next_state = state - 2'b01;  // Transition to the previous state
            end else begin
                next_state = state;  // Stay in current state
            end
        end else begin
            next_state = state;  // Stay in current state
        end
    end

endmodule
