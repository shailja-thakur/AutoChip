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
                if (state < 2'b11) begin // increment if not at max
                    state <= state + 1'b1;
                end
            end
            else begin
                if (state > 2'b00) begin // decrement if not at min
                    state <= state - 1'b1;
                end
            end
        end
        // else, state remains unchanged
    end
end

endmodule
