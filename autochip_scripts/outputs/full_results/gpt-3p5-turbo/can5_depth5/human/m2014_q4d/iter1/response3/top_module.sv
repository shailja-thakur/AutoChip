module top_module (
	input clk,
	input in,
	output logic out
);

reg data;
reg prev_out;

always_ff @(posedge clk or posedge out)
begin
	data <= in ^ prev_out;
	prev_out <= out;
	out <= data;
end

endmodule
