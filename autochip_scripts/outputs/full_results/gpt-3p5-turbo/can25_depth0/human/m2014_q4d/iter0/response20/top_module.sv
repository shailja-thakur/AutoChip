module top_module (
	input clk,
	input in,
	output logic out
);

reg flip_flop_output;

always @(posedge clk)
begin
	flip_flop_output <= in ^ out;
end

assign out = flip_flop_output;

endmodule
