module top_module (
	input clk,
	input x,
	output reg z
);

	reg [2:0] s;

	initial begin
		s = 3'b000;
	end

	always @(posedge clk) begin
		// MSB operation
		s[2] <= s[2]; // MSB remains the same as s[2]
		s[2] <= x ^ s[2]; // XOR x with the MSB

		// Middle bit operation
		s[1] <= ~(s[1]); // NOT of the middle bit
		s[1] <= x & s[1]; // AND x with the NOT'd middle bit

		// LSB operation
		s[0] <= ~(s[0]); // NOT of the LSB
		s[0] <= x | s[0]; // OR x with the NOT'd LSB
	end

	// Assign output z
	assign z = ~(|s);

endmodule
