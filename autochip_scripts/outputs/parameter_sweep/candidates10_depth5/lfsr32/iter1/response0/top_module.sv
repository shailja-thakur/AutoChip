module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	// Internal wire declarations
	wire [0:31] feedback;
	wire [0:31] next_state;
	
	// Feedback calculation
	assign feedback[0] = q[31] ^ q[21] ^ q[1] ^ q[0];
	assign feedback[1] = q[0];
	assign feedback[2] = q[1];
	assign feedback[3:31] = q[2:30];
	
	// Next state calculation
	assign next_state = reset ? 32'h1 : feedback;
	
	// Synchronous process
	always @(posedge clk)
	begin
		if (reset)
			q <= 32'h1;
		else
			q <= next_state;
	end
	
endmodule
