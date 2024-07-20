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
                    // Increment counter up to 3
                    if (state != 2'b11)
                        state <= state + 1;
                end
                else begin
                    // Decrement counter down to 0
                    if (state != 2'b00)
                        state <= state - 1;
                end
            end
            // If train_valid is 0, keep the counter value unchanged
        end
    end

endmodule
