module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	// Define the taps
	parameter TAP1 = 32;
	parameter TAP2 = 22;
	parameter TAP3 = 2;
	parameter TAP4 = 1;
	
	// Define internal registers
	reg [31:0] shift_register;
	reg feedback;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_register <= 32'h1; // Reset the shift register to 32'h1
		end else begin
			feedback = shift_register[TAP1] ^ shift_register[TAP2] ^ shift_register[TAP3] ^ shift_register[TAP4];
			shift_register <= {shift_register[30:0], feedback}; // Shift the register and update using feedback
		end
	end
	
	assign q = shift_register;
	
endmodule
