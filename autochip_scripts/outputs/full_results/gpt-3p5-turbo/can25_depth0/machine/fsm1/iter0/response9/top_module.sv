module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 0;
    else
        state <= next_state;
end

always @(state, in) begin
    case (state)
        0: if (in) next_state = 0; else next_state = 1;
        1: if (in) next_state = 1; else next_state = 0;
        default: next_state = 0;
    endcase
end

always @(posedge clk) begin
    if (areset)
        out <= 1'b0;
    else
        out <= (state == 1'b1) ? 1'b1 : 1'b0;
end

endmodule
