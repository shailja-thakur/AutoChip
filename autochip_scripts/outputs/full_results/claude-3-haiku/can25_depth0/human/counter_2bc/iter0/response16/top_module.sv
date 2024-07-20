module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Weakly not-taken state
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) // Increment if not at max
                    state <= state + 1'b1;
            end
            else begin
                if (state > 2'b00) // Decrement if not at min
                    state <= state - 1'b1;
            end
        end
        // If train_valid is 0, keep the state unchanged
    end
end

endmodule
