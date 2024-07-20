module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] d;
reg [2:0] q;

always @(posedge clk) begin
	d[0] <= x ^ q[0];
	d[1] <= ~q[1] & x;
	d[2] <= ~q[2] | x;

	q <= d;
end

assign z = ~(q[0] ^ q[1] ^ q[2]);

endmodule
