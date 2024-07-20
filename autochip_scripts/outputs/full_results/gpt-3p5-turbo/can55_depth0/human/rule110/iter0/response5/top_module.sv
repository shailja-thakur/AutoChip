module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] next_q; // next state of each cell

	always @(posedge clk) begin
		if (load) begin
			q <= data; // load input data if load is high
		end else begin
			q <= next_q; // update current state using next state
		end
	end

	// boundary conditions
	assign next_q[0] = (q[1] & q[0]) | (~q[1] & ~q[0]);
	assign next_q[511] = (~q[511] & ~q[510]);
	
	// update rules for interior cells
	genvar i;
	generate
		for (i = 1; i < 511; i = i + 1) begin: rule_loop
			always @(*) begin
				case({q[i - 1], q[i], q[i + 1]})
					3'b111: next_q[i] = 1;
					3'b110: next_q[i] = 0;
					3'b101: next_q[i] = 1;
					3'b100: next_q[i] = 1;
					3'b011: next_q[i] = 1;
					3'b010: next_q[i] = 1;
					3'b001: next_q[i] = 1;
					3'b000: next_q[i] = 0;
				endcase
			end
		end
	endgenerate

endmodule
