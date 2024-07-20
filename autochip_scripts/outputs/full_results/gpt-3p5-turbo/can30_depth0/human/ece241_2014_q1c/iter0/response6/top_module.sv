module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] s_temp;

	assign s[7:0] = s_temp[7:0];
	assign overflow = s_temp[8];

	always @(*) begin
		s_temp = a + b;
	end

endmodule
