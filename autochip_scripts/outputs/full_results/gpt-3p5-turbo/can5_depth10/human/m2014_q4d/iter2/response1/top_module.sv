module top_module (
	input clk,
	input in,
	output logic out
);

reg d;
always @(posedge clk)
begin
	if (in == 0)
		d <= 0;
	else
		d <= ~out;
end

always @(posedge clk)
begin
	out <= d;
end

endmodule
