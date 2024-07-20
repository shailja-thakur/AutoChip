module top_module (
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] s,
	output reg overflow
);

	always @(a, b) begin
		reg [8:0] temp;
		temp = a + b;
		s = temp[7:0];
		overflow = temp[8];
	end

endmodule
