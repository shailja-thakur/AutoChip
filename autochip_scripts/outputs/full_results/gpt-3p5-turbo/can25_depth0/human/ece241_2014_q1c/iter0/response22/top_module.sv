module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	reg [7:0] sum;
	reg carry;

	always @*
	begin
		sum = a + b;
		if (sum >= 128 || sum <= -129)
			overflow = 1;
		else
			overflow = 0;
	end

	assign s = sum;
endmodule
