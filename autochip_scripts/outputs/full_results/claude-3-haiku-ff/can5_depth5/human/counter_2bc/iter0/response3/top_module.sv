module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_comb begin
    next_state = state;
    if (areset) begin
        next_state = 2'b01; // reset to weakly not-taken
    end
    else if (train_valid) begin
        if (train_taken) begin
            next_state = (state == 2'b11) ? 2'b11 : state + 2'b01; // increment up to 3
        end
        else begin
            next_state = (state == 2'b00) ? 2'b00 : state - 2'b01; // decrement down to 0
        end
    end
end

always_ff @(posedge clk) begin
    state <= next_state;
end

endmodule
