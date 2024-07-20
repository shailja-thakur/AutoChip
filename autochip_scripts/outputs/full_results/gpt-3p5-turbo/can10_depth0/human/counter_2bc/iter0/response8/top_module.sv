module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Reset the counter to weakly not-taken
    end else if (train_valid) begin
        if (train_taken) begin
            if (state < 3) begin
                state <= state + 1; // Increment the counter (up to a maximum of 3)
            end
        end else begin
            if (state > 0) begin
                state <= state - 1; // Decrement the counter (down to a minimum of 0)
            end
        end
    end
end

endmodule
