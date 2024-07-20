module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg D;

always @(posedge clk) begin
    if (L)
        D <= R;
    else if (E)
        D <= w;
end

always @(posedge clk) begin
    if (L)
        Q <= D;
    else if (E)
        Q <= D;
end

endmodule
