module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // reset to weakly not-taken
    end
    else begin
        state <= next_state;
    end
end

always_comb begin
    // Default: keep current state
    next_state = state;

    // Increment counter if training is valid and taken
    if (train_valid && train_taken) begin
        if (state < 3) begin
            next_state = state + 1;
        end
    end
    // Decrement counter if training is valid and not taken
    else if (train_valid && !train_taken) begin
        if (state > 0) begin
            next_state = state - 1;
        end
    end
end

endmodule
