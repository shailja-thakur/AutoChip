module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
	
	// Internal wires
	wire [511:0] left;
	wire [511:0] right;
	wire [511:0] center_next;
	
	// Generate the left, center, and right neighbors
	genvar i;
	generate
		for (i = 1; i < 512; i = i + 1) begin : gen_neighbors
			assign left[i] = q[i-1];
			assign right[i] = q[i+1];
		end
	endgenerate
	
	// Calculate the next state of the center cells
	genvar j;
	generate
		for (j = 1; j < 512; j = j + 1) begin : gen_next_state
			assign center_next[j] = left[j] ^ right[j];
		end
	endgenerate
	
	// Load initial state of the system if load is high
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end
	end
	
	// Update the state of the system each clock cycle
	always @(posedge clk) begin
		if (!load) begin
			q[1:510] <= center_next[1:510];
			q[0] <= 0;
			q[511] <= 0;
		end
	end
	
endmodule
