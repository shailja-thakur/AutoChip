module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// State transition logic
always @(*) begin
    case (state)
        1'b0: next_state = j ? 1'b1 : 1'b0;
        1'b1: next_state = k ? 1'b0 : 1'b1;
    endcase
end

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 1'b0;
    else
        state <= next_state;
end

// Output logic
always @(*) begin
    out = state;
end

endmodule
