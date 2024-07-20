module top_module (
	input clk,
	input in,
	output logic out
);

reg data;
reg flip_flop;

always @(posedge clk)
begin
	flip_flop <= data;
	data <= in ^ flip_flop;
end

assign out = flip_flop;

endmodule
