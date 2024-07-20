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
                if (state < 3) begin
                    state <= state + 1; // increment counter up to 3
                end
            end
            else begin
                if (state > 0) begin
                    state <= state - 1; // decrement counter down to 0
                end
            end
        end
        // if train_valid == 0, keep the counter value unchanged
    end
end

endmodule
