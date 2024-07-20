module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Initialize to weakly not-taken
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state < 3'b11) begin
                    state <= state + 1; // Increment counter up to 3
                end
            end
            else begin
                if (state > 2'b00) begin
                    state <= state - 1; // Decrement counter down to 0
                end
            end
        end
        // If train_valid is 0, keep the state unchanged
    end
end

endmodule
