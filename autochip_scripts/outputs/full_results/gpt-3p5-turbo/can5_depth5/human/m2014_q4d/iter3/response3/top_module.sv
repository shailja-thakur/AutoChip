module top_module (
	input clk,
	input in,
	output logic out
);

reg data;
always @(posedge clk)
begin
	data <= in;
end

always @(posedge clk)
begin
	out <= data;
end

endmodule
