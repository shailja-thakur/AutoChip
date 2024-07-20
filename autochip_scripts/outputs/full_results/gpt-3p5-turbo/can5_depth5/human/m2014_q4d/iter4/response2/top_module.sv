module top_module (
	input clk,
	input in,
	output logic out
);

reg data;
reg flip;
always_ff @(posedge clk)
begin
	data <= in ^ flip;
	flip <= data;
end

always_ff @(posedge clk)
begin
	out <= flip;
end

endmodule
