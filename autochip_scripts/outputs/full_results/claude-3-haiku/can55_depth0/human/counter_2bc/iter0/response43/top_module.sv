module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Weakly not-taken
    end
    else if (train_valid) begin
        if (train_taken) begin
            state <= (state == 2'b11) ? 2'b11 : state + 1'b1; // Increment up to 3
        end
        else begin
            state <= (state == 2'b00) ? 2'b00 : state - 1'b1; // Decrement down to 0
        end
    end
    // If train_valid is 0, state remains unchanged
end

endmodule
