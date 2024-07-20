module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg mux_out;

always @(*) begin
    if (L)
        mux_out = R;
    else if (E)
        mux_out = w;
    else
        mux_out = Q;
end

always @(posedge clk) begin
    Q <= mux_out;
end

endmodule
