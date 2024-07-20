module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Register to store the values
	reg [3:0] shift_reg;
	
	// Assign the MSB of shift register to the output
	assign out = shift_reg[3]; 
	
	// Always block triggered on clock edge
	always @(posedge clk) begin
		if (!resetn) begin
			// Synchronous reset, active-low
			shift_reg <= 4'b0000;
		end else begin
			// Shift right and load the input value
			shift_reg <= {shift_reg[2:0], in};
		end
	end
endmodule
