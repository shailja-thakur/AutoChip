module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] d;
wire out_reg;

assign out = out_reg;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		d <= 4'b0;
	else
		d <= {d[2:0], in};
end

always @(posedge clk) begin
	out_reg <= d[0];
end

endmodule
