module top_module (
	input clk,
	input in,
	output logic out
);

reg d;
reg q;
always @(posedge clk) begin
	d = in ^ q;
	q <= #1 d;
end

assign out = q;

endmodule
