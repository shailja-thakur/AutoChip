module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01;  // weakly not-taken
    end
    else if (train_valid) begin
        if (train_taken) begin
            if (state < 2'b11) begin
                state <= state + 1;  // Increment the counter
            end
        end
        else begin
            if (state > 2'b00) begin
                state <= state - 1;  // Decrement the counter
            end
        end
    end
    // If not training (train_valid = 0), the counter keeps its value unchanged
end

endmodule
