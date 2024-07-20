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
    else if (train_valid) begin
        if (train_taken) begin
            if (state < 2'b11) // counter can only increment up to 3
                state <= state + 1'b1;
        end
        else begin
            if (state > 2'b00) // counter can only decrement down to 0
                state <= state - 1'b1;
        end
    end
    // else, state remains unchanged when train_valid = 0
end

endmodule
