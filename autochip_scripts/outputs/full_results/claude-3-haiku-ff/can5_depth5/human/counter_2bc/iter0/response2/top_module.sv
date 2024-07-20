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
    else begin
        if (train_valid && train_taken) begin
            if (state < 2'b11) // check for maximum value
                state <= state + 1'b1; // increment
        end
        else if (train_valid && !train_taken) begin
            if (state > 2'b00) // check for minimum value
                state <= state - 1'b1; // decrement
        end
        // else keep state unchanged
    end
end

endmodule
