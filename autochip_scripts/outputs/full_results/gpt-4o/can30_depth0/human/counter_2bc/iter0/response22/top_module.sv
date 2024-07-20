module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // weakly not-taken
        end else if (train_valid) begin
            if (train_taken && state < 3) begin
                state <= state + 1; // increment
            end else if (!train_taken && state > 0) begin
                state <= state - 1; // decrement
            end
        end
        // If train_valid is 0, state remains unchanged.
    end

endmodule
