module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	// Define the taps for the LFSR
	parameter TAP_1 = 32;
	parameter TAP_2 = 22;
	parameter TAP_3 = 2;
	parameter TAP_4 = 1;
	
	// Define internal signals
	reg [31:0] shift_register;
	reg feedback;
	
	// Define initial value of the shift register
	initial begin
		shift_register = 32'b1;
	end
	
	// Synchronous reset
	always @(posedge clk) begin
		if (reset) begin
			shift_register <= 32'b1;
			q <= 32'b1;
		end else begin
			feedback = shift_register[TAP_1] ^ shift_register[TAP_2] ^ shift_register[TAP_3] ^ shift_register[TAP_4];
			shift_register <= {shift_register[30:0], feedback};
			q <= shift_register;
		end
	end
	
endmodule
