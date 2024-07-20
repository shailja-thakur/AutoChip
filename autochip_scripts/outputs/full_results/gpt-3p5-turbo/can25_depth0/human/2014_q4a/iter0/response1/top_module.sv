module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

// D flip-flop
always @(posedge clk)
begin
    if (E && L)
        Q <= R;
    else if (E)
        Q <= w;
end

endmodule
