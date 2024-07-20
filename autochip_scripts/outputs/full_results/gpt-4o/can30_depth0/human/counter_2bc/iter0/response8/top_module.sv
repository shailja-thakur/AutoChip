module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // weakly not-taken
    end else if (train_valid) begin
        if (train_taken) begin
            if (state < 2'b11) begin
                state <= state + 1; // Increment counter
            end else begin
                state <= 2'b11; // Saturate to maximum value 3
            end
        end else begin
            if (state > 2'b00) begin
                state <= state - 1; // Decrement counter
            end else begin
                state <= 2'b00; // Saturate to minimum value 0
            end
        end
    end else begin
        state <= state; // Keep counter value unchanged
    end
end

endmodule
