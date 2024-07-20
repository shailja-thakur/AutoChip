module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Weakly not-taken state
    end else if (train_valid) begin
        if (train_taken) begin
            if (state < 2'b11) state <= state + 1; // Increment unless at max value (3)
        end else begin
            if (state > 2'b00) state <= state - 1; // Decrement unless at min value (0)
        end
    end
    // If train_valid == 0, state remains unchanged
end

endmodule
