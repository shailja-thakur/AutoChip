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
            if (state != 2'b11) // check if state is not already at maximum
                state <= state + 1; // increment state
        end
        else begin
            if (state != 2'b00) // check if state is not already at minimum
                state <= state - 1; // decrement state
        end
    end
    // else, if train_valid is 0, keep the state unchanged
end

endmodule
