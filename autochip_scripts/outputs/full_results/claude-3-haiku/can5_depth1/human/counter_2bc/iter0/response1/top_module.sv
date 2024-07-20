module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Initialize to weakly not-taken
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state < 3'b11) // Increment up to 3
                    state <= state + 1'b1;
            end
            else begin
                if (state > 2'b00) // Decrement down to 0
                    state <= state - 1'b1;
            end
        end
        // If train_valid is 0, keep the state unchanged
    end
end

endmodule
