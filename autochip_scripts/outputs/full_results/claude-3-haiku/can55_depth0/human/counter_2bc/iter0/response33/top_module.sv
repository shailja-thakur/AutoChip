module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset to weakly not-taken
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state != 2'b11) // check for maximum value of 3
                    state <= state + 1;
            end
            else begin
                if (state != 2'b00) // check for minimum value of 0
                    state <= state - 1;
            end
        end
        // if train_valid is 0, keep the state unchanged
    end
end

endmodule
