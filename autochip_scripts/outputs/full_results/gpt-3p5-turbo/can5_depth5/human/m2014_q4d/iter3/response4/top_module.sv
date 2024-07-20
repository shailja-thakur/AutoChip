module top_module (
	input clk,
	input in,
	output logic out
);

reg data;
reg data_temp;
always_ff @(posedge clk)
begin
	data_temp <= in;
	data <= data_temp;
end

always_comb
begin
	out = data;
end

endmodule
