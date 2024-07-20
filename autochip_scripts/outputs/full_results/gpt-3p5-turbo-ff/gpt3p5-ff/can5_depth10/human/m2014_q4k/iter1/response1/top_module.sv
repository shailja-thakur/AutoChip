module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] d;
reg [3:0] q;

assign out = q[0];

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		d <= 4'b0;
	else
		d <= {d[2:0], in};
end

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		q <= 4'b0;
	else
		q <= d;
end

endmodule
