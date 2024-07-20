module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] next_state;

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01;
    end
    else begin
        state <= next_state;
    end
end

always_comb begin
    next_state = state;
    case ({train_valid, train_taken})
        2'b10: next_state = state - 1;
        2'b11: next_state = state + 1;
    endcase
    if (next_state > 3) begin
        next_state = 3;
    end
    else if (next_state < 0) begin
        next_state = 0;
    end
end

endmodule
