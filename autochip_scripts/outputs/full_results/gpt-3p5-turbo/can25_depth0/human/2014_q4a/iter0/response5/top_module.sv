module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg D, S;

always @(posedge clk) begin
    if (L)
        D <= R;
    else if (E)
        D <= S;
    else
        D <= 1'b0;
end

always @(posedge clk) begin
    if (L)
        S <= w;
    else if (E)
        S <= Q;
end

always @(posedge clk) begin
    if (L)
        Q <= D;
end

endmodule
