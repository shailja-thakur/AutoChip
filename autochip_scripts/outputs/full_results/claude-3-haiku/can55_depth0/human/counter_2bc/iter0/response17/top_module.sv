module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset to weakly not-taken
    end
    else if (train_valid) begin
        if (train_taken) begin
            state <= (state == 2'b11) ? 2'b11 : state + 1'b1; // increment if not already at max
        end
        else begin
            state <= (state == 2'b00) ? 2'b00 : state - 1'b1; // decrement if not already at min
        end
    end
    // else, keep state unchanged
end

endmodule
