module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);

reg state_reg;
assign state = state_reg;

always @(posedge clk) begin
    if (a && b)
        q <= state_reg;
    else if (a)
        q <= ~state_reg;
    else
        q <= b;

    state_reg <= q;
end

endmodule
