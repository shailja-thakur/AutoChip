module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    // State definitions for better readability
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;
    
    // Sequential block for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_1; // Reset state to 1 when asynchronous reset is asserted
        end
        else if(train_valid) begin
            if (train_taken && (state < STATE_3)) begin
                state <= state + 1; // Transition to next state if train_taken and state is less than 3
            end
            else if (!train_taken && (state > 0)) begin
                state <= state - 1; // Transition to previous state if not taken and state is greater than 0
            end
            // remain in current state if neither conditions are satisfied
        end
    end
endmodule
