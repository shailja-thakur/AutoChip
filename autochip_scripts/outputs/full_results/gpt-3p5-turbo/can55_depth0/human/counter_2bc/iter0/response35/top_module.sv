module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01; // Reset the counter to weakly not-taken (2'b01)
    else if (train_valid) begin
        if (train_taken) begin
            if (state < 2'b11) // Increment counter (up to a maximum of 3)
                state <= state + 1;
        end else begin
            if (state > 2'b00) // Decrement counter (down to a minimum of 0)
                state <= state - 1;
        end
    end
end

endmodule
