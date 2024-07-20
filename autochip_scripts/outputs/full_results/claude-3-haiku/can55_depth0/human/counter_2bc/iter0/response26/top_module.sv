module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// Declare internal signals
logic [1:0] next_state;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Reset counter to weakly not-taken
    end
    else begin
        state <= next_state;
    end
end

always_comb begin
    // Default next_state is to keep the current state
    next_state = state;

    // Increment counter if training is valid and taken
    if (train_valid && train_taken) begin
        // Saturating increment (up to 3)
        if (state < 2'b11) begin
            next_state = state + 2'b01;
        end
    end
    // Decrement counter if training is valid and not taken
    else if (train_valid && !train_taken) begin
        // Saturating decrement (down to 0)
        if (state > 2'b00) begin
            next_state = state - 2'b01;
        end
    end
end

endmodule
