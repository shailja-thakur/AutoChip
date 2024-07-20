module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define state registers
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset to weakly not-taken state
            state <= 2'b01;
        end
        else if (train_valid) begin
            // When training is valid
            if (train_taken) begin
                // Increment the counter, saturating at 3
                if (state < 2'b11) begin
                    state <= state + 1;
                end
            end
            else begin
                // Decrement the counter, saturating at 0
                if (state > 2'b00) begin
                    state <= state - 1;
                end
            end
        end
    end

endmodule
