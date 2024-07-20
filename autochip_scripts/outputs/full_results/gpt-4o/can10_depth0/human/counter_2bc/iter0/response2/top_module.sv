module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State encoding:
    // 2'b00 - strongly not-taken
    // 2'b01 - weakly not-taken
    // 2'b10 - weakly taken
    // 2'b11 - strongly taken
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    if (state < 2'b11) state <= state + 1; // Increment counter
                end else begin
                    if (state > 2'b00) state <= state - 1; // Decrement counter
                end
            end
        end
    end
endmodule
