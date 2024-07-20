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
        state <= 2'b01; // Reset to weakly not-taken
    end
    else begin
        state <= next_state;
    end
end

always_comb begin
    next_state = state;
    if (train_valid) begin
        if (train_taken) begin
            if (state < 2'b11) begin // Increment if less than 3
                next_state = state + 1'b1;
            end
        end
        else begin
            if (state > 2'b00) begin // Decrement if greater than 0
                next_state = state - 1'b1;
            end
        end
    end
end

endmodule
