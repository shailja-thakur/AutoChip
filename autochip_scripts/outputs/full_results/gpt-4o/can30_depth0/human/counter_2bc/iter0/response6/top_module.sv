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
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    // Increment the counter, but do not exceed 3
                    if (state < 2'b11) state <= state + 1;
                end else begin
                    // Decrement the counter, but do not go below 0
                    if (state > 2'b00) state <= state - 1;
                end
            end
        end
    end
endmodule
