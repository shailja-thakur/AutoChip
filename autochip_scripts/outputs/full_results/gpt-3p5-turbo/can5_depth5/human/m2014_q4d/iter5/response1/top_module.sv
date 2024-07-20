module top_module (
	input clk,
	input in,
	output logic out
);

reg data;
always_ff @(posedge clk)
begin
	data <= in;
end

assign out = data ^ in;

endmodule
