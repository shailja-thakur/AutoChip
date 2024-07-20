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
                if (state < 3) // saturate at 3
                    state <= state + 1;
            end
            else begin
                if (state > 0) // saturate at 0
                    state <= state - 1;
            end
        end
        // else, state remains unchanged
    end
end

endmodule
