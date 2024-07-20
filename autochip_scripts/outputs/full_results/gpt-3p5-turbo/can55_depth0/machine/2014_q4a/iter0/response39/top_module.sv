module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk)
if (E) begin
    if (L)
        Q <= R;
    else
        Q <= w;
end
else
    Q <= Q;

endmodule
