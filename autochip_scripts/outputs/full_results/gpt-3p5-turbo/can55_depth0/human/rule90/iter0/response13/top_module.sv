module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	// Internal wires
	wire [510:0] left;
	wire [510:0] center;
	wire [510:0] right;
	wire [510:0] next_state;
	
	// Boundary conditions
	assign left[0] = 0;
	assign right[510] = 0;
	
	// XOR logic
	assign center = q[510:0];
	assign left[510:0] = q[511:1];
	assign right[0:510] = q[510:0];
	
	assign next_state = ~(left & center & right) | (left & center & ~right) | (left & ~center & right) | (left & ~center & ~right) | (~left & center & right) | (~left & center & ~right) | (~left & ~center & right) | (~left & ~center & ~right);
	
	// Load data on rising edge of clock
	always @(posedge clk) begin
		if (load)
			q <= data;
		else
			q <= next_state;
	end
	
endmodule
