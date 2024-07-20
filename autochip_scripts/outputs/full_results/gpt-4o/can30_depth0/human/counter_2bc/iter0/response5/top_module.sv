module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken state
        end else if (train_valid) begin
            if (train_taken && state < 2'b11) begin
                // Increment only if not at maximum value
                state <= state + 2'b01;
            end else if (!train_taken && state > 2'b00) begin
                // Decrement only if not at minimum value
                state <= state - 2'b01;
            end
        end
    end

endmodule
