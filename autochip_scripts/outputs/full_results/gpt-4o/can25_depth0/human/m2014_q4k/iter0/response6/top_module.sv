module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	reg [3:0] shift_reg;
	
	always @(posedge clk) begin
		if (!resetn)
			shift_reg <= 4'b0000;  // Synchronous reset to 0
		else
			shift_reg <= {shift_reg[2:0], in}; // Shift operation
	end

	assign out = shift_reg[3]; // Output the MSB
	
endmodule
