module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg D;

always @ (posedge clk) begin
    if (L)
        D <= R;
    else if (E)
        D <= w;
    else
        D <= Q;
end

always @ (posedge clk) begin
    if (L)
        Q <= D;
    else
        Q <= 1'b0;
end

endmodule
