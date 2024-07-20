module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		integer i;
		reg [511:0] next_q;
	
		if (load) begin
			q <= data;
		end else begin
			next_q[0] = 0; // Left boundary
			next_q[511] = 0; // Right boundary
			// Update the inner cells
			for (i = 1; i < 511; i = i + 1) begin
				case ({q[i+1], q[i], q[i-1]})
					3'b111: next_q[i] = 0;
					3'b110: next_q[i] = 1;
					3'b101: next_q[i] = 1;
					3'b100: next_q[i] = 0;
					3'b011: next_q[i] = 1;
					3'b010: next_q[i] = 1;
					3'b001: next_q[i] = 1;
					3'b000: next_q[i] = 0;
				endcase
			end
			// Update the boundaries
			next_q[0] = (q[1] == 1 && q[0] == 0) ? 1 : 0; // Applying the rule considering the boundary condition
			next_q[511] = (q[510] == 1 && q[511] == 0) ? 1 : 0; // Applying the rule considering the boundary condition
			
			q <= next_q;
		end
	end
	
endmodule
