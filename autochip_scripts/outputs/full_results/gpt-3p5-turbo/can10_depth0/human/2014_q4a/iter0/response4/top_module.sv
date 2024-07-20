module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg Q_next;

always @(posedge clk)
begin
    if (L)
        Q <= R;
    else if (E)
        Q <= Q_next;
end

assign Q_next = (w & E) ? R : Q;

endmodule
