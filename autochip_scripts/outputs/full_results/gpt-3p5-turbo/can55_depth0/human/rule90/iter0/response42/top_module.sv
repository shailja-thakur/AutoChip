module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	// Internal wire to hold the next state of each cell
	wire [511:0] next_q;

	// Assign the next state of each cell
	assign next_q[0] = (load) ? data[0] : (q[1] ^ q[0] ^ 0);
	assign next_q[511] = (load) ? data[511] : (q[510] ^ q[511] ^ 0);
	
	genvar i;
	generate
		for(i=1; i<511; i=i+1) begin : loop
			assign next_q[i] = (load) ? data[i] : (q[i-1] ^ q[i] ^ q[i+1]);
		end
	endgenerate

	// Synchronous always block to update the current state of the cells 
	always @(posedge clk) begin
		q <= next_q;
	end

endmodule
