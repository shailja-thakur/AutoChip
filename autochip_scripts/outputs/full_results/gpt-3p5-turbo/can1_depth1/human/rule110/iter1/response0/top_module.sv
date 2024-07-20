module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if (load)
			q <= data;
		else begin
			reg [511:0] q_next; // Next state of the cells
			
			// Set the boundary cells to zero (off)
			q_next[0] = 0;
			q_next[511] = 0;
			
			// Compute the next state of each cell
			for (int i = 1; i < 511; i = i + 1) begin
				case ({q[i-1], q[i], q[i+1]})
					3'b111: q_next[i] = 0;
					3'b110: q_next[i] = 1;
					3'b101: q_next[i] = 1;
					3'b100: q_next[i] = 0;
					3'b011: q_next[i] = 1;
					3'b010: q_next[i] = 1;
					3'b001: q_next[i] = 1;
					3'b000: q_next[i] = 0;
				endcase
			end

			q <= q_next; // Update the state of the cells
		end
	end
endmodule
