module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;  // Reset the counter to weakly not-taken
        end else if (train_valid) begin
            if (train_taken && state < 2'b11) begin
                state <= state + 1;  // Increment the counter (up to a maximum of 3)
            end else if (!train_taken && state > 2'b00) begin
                state <= state - 1;  // Decrement the counter (down to a minimum of 0)
            end
        end
    end
endmodule
