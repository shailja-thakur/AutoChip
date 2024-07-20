module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk, posedge areset) begin
    if (areset)
        state <= 2'b01; // reset to weakly not-taken
    else begin
        if (train_valid) begin
            if (train_taken)
                state <= (state == 2'b11) ? 2'b11 : state + 1'b1; // increment if not max
            else
                state <= (state == 2'b00) ? 2'b00 : state - 1'b1; // decrement if not min
        end
        // else, state remains unchanged
    end
end

endmodule
