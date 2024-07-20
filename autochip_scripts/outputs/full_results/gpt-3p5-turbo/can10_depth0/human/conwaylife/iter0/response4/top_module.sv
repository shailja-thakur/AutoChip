module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	// Register to hold the next state of q
	reg [255:0] next_q;

	// Wires for cell states and neighbor count
	wire [255:0] cell_states;
	wire [255:0] neighbor_counts;

	// Generate next state of q
	always @ (posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= next_q;
		end
	end

	// Assign cell states based on neighbor counts
	assign cell_states = q;

	// Compute neighbor counts for each cell
	assign neighbor_counts = q[15:0] + q[31:16] + q[47:32] + q[63:48] + 
		q[79:64] + q[95:80] + q[111:96] + q[127:112] + 
	    q[143:128] + q[159:144] + q[175:160] + q[191:176] +
	    q[207:192] + q[223:208] + q[239:224] + q[255:240];

	// Calculate next state of q based on neighbor counts and current cell states
	always @ (*) begin
		for (integer row = 0; row < 16; row = row + 1) begin
			for (integer col = 0; col < 16; col = col + 1) begin
				integer index = row * 16 + col;
				case (neighbor_counts[index])
					2: next_q[index] = cell_states[index];
					3: next_q[index] = 1;
					default: next_q[index] = 0;
				endcase
			end
		end
	end

endmodule
