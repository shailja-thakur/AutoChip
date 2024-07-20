module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] temp; // Use one extra bit for overflow detection

	always @(*) begin
		temp = a + b;
		if (temp[8] == 1) // Check if overflow has occurred
			overflow = 1;
		else
			overflow = 0;
		s = temp[7:0];
	end
endmodule
