module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] temp_s;
	wire temp_overflow;
	assign temp_s = a + b;
	
	always @(temp_s)
	begin
		s = temp_s[7:0];
		overflow = temp_s[8];
	end

endmodule
