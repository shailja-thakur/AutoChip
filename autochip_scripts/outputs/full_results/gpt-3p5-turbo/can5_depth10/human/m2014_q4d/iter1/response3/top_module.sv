module top_module (
	input clk,
	input in,
	output logic out
);

reg d;
always @(posedge clk or negedge out)
begin
	if (~out)
		d <= in;
	else
		d <= ~in;
	out <= d;
end

endmodule
