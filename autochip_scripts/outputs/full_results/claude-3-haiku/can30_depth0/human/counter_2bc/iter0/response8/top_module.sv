module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Reset to weakly not-taken
    end
    else if (train_valid) begin
        if (train_taken) begin
            if (state < 3'b11) // Increment up to maximum of 3
                state <= state + 1'b1;
        end
        else begin
            if (state > 2'b00) // Decrement down to minimum of 0
                state <= state - 1'b1;
        end
    end
    // When train_valid = 0, state remains unchanged
end

endmodule
