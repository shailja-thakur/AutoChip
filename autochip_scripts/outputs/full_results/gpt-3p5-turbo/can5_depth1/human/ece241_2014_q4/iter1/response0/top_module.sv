module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
reg d1_next, d2_next, d3_next;

assign z = ~(d1 ^ d2 ^ d3);

always @(posedge clk) begin
	d1 <= d1_next;
	d2 <= d2_next;
	d3 <= d3_next;
end

always @(x, d1, d2, d3) begin
	d1_next = x ^ d1;
	d2_next = ~d2 & d1;
	d3_next = ~d3 | ~d2;
end

endmodule
