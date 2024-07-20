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
    if (E)
        D <= L ? R : Q;
    else
        D <= Q;
end

always @(posedge clk) begin
    if (L)
        Q <= R;
    else if (E)
        Q <= D;
end

assign D = w;

endmodule
