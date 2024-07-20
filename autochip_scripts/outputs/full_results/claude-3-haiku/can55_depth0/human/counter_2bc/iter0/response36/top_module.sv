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
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state != 2'b11) // don't increment if already at max
                    state <= state + 1'b1;
            end
            else begin
                if (state != 2'b00) // don't decrement if already at min
                    state <= state - 1'b1;
            end
        end
        // if train_valid is 0, keep state unchanged
    end
end

endmodule
