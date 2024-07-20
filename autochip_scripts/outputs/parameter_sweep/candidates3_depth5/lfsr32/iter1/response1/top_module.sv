module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	// Register for the LFSR
	reg [31:0] shift_register;
	
	// Tap positions
	parameter [31:0] taps = 32'b01000100000000000000000000000001;
	
	always @(posedge clk) begin
		if (reset) begin
			shift_register <= 32'h1;
		end else begin
			shift_register <= {shift_register[30:0], 
							   shift_register[31] ^ (shift_register[21] ^ shift_register[1] ^ shift_register[0])};
		end
	end
	
	assign q = shift_register;
endmodule
