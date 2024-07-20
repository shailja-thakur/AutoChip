module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	wire [3:0] y4_bits;
	
	assign y4_bits = {y[2], y[3], y[5], y[6]};
	
	always @* begin
		Y2 = y[1] & ~w;
		Y4 = y4_bits & w;
	end
	
endmodule
