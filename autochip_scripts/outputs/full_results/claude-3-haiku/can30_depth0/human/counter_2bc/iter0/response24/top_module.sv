module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Reset counter to weakly not-taken
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state != 2'b11) // Check if counter is not at maximum
                    state <= state + 1'b1; // Increment counter
            end
            else begin
                if (state != 2'b00) // Check if counter is not at minimum
                    state <= state - 1'b1; // Decrement counter
            end
        end
        // If train_valid is 0, keep the counter value unchanged
    end
end

endmodule
