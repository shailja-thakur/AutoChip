module top_module (
	input clk,
	input x,
	output z
);

reg q1, q2, q3;
wire xnor;
wire [2:0] d;

always @(posedge clk) begin
	// D flip-flop equations
	q1 <= d[0];
	q2 <= d[1];
	q3 <= d[2];
end

assign d[0] = (x ^ q1) & (~q1);
assign d[1] = (x ^ ~q2) & (~q2);
assign d[2] = (x ^ ~q3) & (~q3);

assign xnor = ~(q1 ^ q2 ^ q3);
assign z = xnor;

endmodule
