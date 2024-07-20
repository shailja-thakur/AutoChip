module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset to weakly not-taken
    end
    else if (train_valid) begin
        if (train_taken) begin
            if (state < 3'b11) // check for overflow
                state <= state + 1'b1; // increment counter
        end
        else begin
            if (state > 2'b00) // check for underflow
                state <= state - 1'b1; // decrement counter
        end
    end
    // if train_valid == 0, state remains unchanged
end

endmodule
