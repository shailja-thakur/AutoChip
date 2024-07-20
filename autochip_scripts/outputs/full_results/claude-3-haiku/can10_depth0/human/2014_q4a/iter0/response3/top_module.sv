module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg next_Q;

always @(posedge clk) begin
    if (L)
        Q <= R;
    else if (E)
        Q <= w;
    else
        Q <= next_Q;
end

always @(*) begin
    if (E)
        next_Q = w;
    else
        next_Q = Q;
end

endmodule
