module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_comb begin
    // Default: Keep the current state
    next_state = state;
    
    // Increment the counter if train_valid and train_taken are both 1
    if (train_valid && train_taken) begin
        if (state < 2'b11) begin
            next_state = state + 1'b1;
        end
    end
    // Decrement the counter if train_valid is 1 and train_taken is 0
    else if (train_valid && !train_taken) begin
        if (state > 2'b00) begin
            next_state = state - 1'b1;
        end
    end
end

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b01; // Reset to weakly not-taken
    end
    else begin
        state <= next_state;
    end
end

endmodule
