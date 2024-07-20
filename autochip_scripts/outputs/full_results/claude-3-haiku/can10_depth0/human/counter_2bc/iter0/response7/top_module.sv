module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Initialize to weakly not-taken (2'b01)
    end
    else if (train_valid) begin
        if (train_taken) begin
            if (state < 3) // Increment up to maximum of 3
                state <= state + 1;
        end
        else begin
            if (state > 0) // Decrement down to minimum of 0
                state <= state - 1;
        end
    end
end

endmodule
