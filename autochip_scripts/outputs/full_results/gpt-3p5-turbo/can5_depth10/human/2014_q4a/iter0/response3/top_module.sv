module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg D;

// logic to determine the value of D
always @(posedge clk) begin
    if (E && L)
        D <= R;
    else if (E)
        D <= Q;
    else
        D <= w;
end
    
// flip-flop
always @(posedge clk) begin
    if (L)
        Q <= R;
    else
        Q <= D;
end

endmodule
