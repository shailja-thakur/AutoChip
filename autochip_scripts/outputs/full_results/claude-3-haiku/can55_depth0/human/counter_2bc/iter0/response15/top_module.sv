module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset to weakly not-taken
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state < 3'b11) // check for saturation
                    state <= state + 1'b1; // increment counter
            end
            else begin
                if (state > 2'b00) // check for saturation
                    state <= state - 1'b1; // decrement counter
            end
        end
        // If train_valid is 0, keep the counter value unchanged
    end
end

endmodule
