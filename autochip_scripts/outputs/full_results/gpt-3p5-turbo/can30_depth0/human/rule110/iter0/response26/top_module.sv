module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	// Internal wires for calculating the next state
	wire [511:0] next_q;
	
	// Next state calculation
	assign next_q[0] = (q[1] & q[0] & data[0]) | (q[1] & !q[0] & !data[0]);
	assign next_q[1:510] = (q[2:511] & q[1:510] & q[0:509] & data[1:510]) | (q[2:511] & ~q[1:510] & ~q[0:509] & ~data[1:510]);
	assign next_q[511] = (q[511] & q[510] & data[511]) | (q[511] & !q[510] & !data[511]);
	
	// Synchronous circuit for updating the state
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= next_q;
		end
	end
endmodule
