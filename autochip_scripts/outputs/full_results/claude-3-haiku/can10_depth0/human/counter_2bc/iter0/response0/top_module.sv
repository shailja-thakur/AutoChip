module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset to weakly not-taken
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin // check for counter overflow
                    state <= state + 1'b1; // increment counter
                end
            end
            else begin
                if (state > 2'b00) begin // check for counter underflow
                    state <= state - 1'b1; // decrement counter
                end
            end
        end
        // When not training (train_valid = 0), the counter keeps its value unchanged
    end
end

endmodule
