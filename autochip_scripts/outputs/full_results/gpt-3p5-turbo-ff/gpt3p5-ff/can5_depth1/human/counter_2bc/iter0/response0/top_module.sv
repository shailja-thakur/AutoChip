module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken && state < 2'b11) begin
                state <= state + 1; // Increment when train_valid = 1 and train_taken = 1
            end else if (!train_taken && state > 2'b00) begin
                state <= state - 1; // Decrement when train_valid = 1 and train_taken = 0
            end
        end
    end

endmodule
