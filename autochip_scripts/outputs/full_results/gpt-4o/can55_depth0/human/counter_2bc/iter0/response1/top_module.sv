module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always_ff @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b01; // weakly not-taken
    else if (train_valid) begin
        if (train_taken)
            state <= (state != 2'b11) ? state + 1 : state; // increment counter
        else
            state <= (state != 2'b00) ? state - 1 : state; // decrement counter
    end
end

endmodule
