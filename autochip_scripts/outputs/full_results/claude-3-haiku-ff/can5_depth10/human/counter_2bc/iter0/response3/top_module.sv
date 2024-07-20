module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset to weakly not-taken (2'b01)
    end
    else begin
        if (train_valid) begin
            if (train_taken) begin
                if (state != 2'b11) // check for maximum value
                    state <= state + 1; // increment
            end
            else begin
                if (state != 2'b00) // check for minimum value
                    state <= state - 1; // decrement
            end
        end
        // if train_valid = 0, keep the counter value unchanged
    end
end

endmodule
