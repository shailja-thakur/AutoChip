module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [31:0] shift_reg; // register to shift the input bits
	reg [31:0] complement_reg; // register to store the 2's complement of the input

	always @(posedge clk or posedge areset) begin
		if (areset)
			shift_reg <= 0; // reset the shift register to 0
		else
			shift_reg <= {shift_reg[30:0], x}; // shift in the new input bit

		if (!areset)
			complement_reg <= ~shift_reg + 1; // calculate the 2's complement of the input
	end

	assign z = complement_reg[0]; // output the least significant bit of the 2's complement

endmodule
