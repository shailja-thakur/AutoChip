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
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state < 3) begin
                    state <= state + 1; // Increment counter up to max 3
                end
            end
            else begin
                if (state > 0) begin
                    state <= state - 1; // Decrement counter down to min 0
                end
            end
        end
        // If train_valid == 0, state remains unchanged
    end
end

endmodule
