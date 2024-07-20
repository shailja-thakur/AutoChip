module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Define the width of the shift register
	parameter WIDTH = 4;

	reg [WIDTH-1:0] shift_reg;
	reg [WIDTH-1:0] next_shift_reg;
	
	// Implement the D flip-flops
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			shift_reg <= 0;
		else
			shift_reg <= next_shift_reg;
	end
	
	// Assign the input to the first flip-flop
	always @(posedge clk) begin
		if (!resetn)
			next_shift_reg[0] <= 0;
		else
			next_shift_reg[0] <= in;
	end
	
	// Implement the shift register
	always @(posedge clk) begin
		if (!resetn)
			for (int i = 1; i < WIDTH; i = i + 1)
				next_shift_reg[i] <= 0;
		else
			for (int i = 1; i < WIDTH; i = i + 1)
				next_shift_reg[i] <= shift_reg[i-1];
	end
	
	// Assign the output
	assign out = shift_reg[WIDTH-1];
	
endmodule
