module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	reg y1;
	reg [3:0] y4_bits;
	
	always @(y, w) begin
		y1 = y[1] & ~w;
		y4_bits = {y[6], y[5], y[3], y[2]};
		
		Y2 = y1;
		Y4 = y4_bits & w;
	end
endmodule
