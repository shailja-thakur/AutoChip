module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] sum;
	reg adder_overflow;

	always @(*) begin
		{adder_overflow, s} = a + b;
	end

	assign overflow = adder_overflow;

endmodule
