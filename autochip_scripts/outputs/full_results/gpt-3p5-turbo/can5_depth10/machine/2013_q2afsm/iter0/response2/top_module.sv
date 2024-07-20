module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [3:1] state;
	reg [3:1] next;

	always @(posedge clk) begin
		if (~resetn)
			state <= 3'b001; // Starting state A
		else
			state <= next;
	end

	always @*
	begin
		case (state)
			3'b001: // State A
				begin
					if (r[3])
						next = 3'b100; // Next state D
					else if (r[2])
						next = 3'b011; // Next state C
					else if (r[1])
						next = 3'b010; // Next state B
					else
						next = 3'b001; // Next state A
				end
			3'b010: // State B
				begin
					if (r[1])
						next = 3'b010; // Next state B
					else
						next = 3'b001; // Next state A
				end
			3'b011: // State C
				begin
					if (r[2])
						next = 3'b011; // Next state C
					else
						next = 3'b001; // Next state A
				end
			3'b100: // State D
				begin
					if (r[3])
						next = 3'b100; // Next state D
					else
						next = 3'b001; // Next state A
				end
			default: // Any other state
				next = 3'b001; // Next state A
		endcase
	end

	assign g[3] = (state == 3'b100); // Bit 3 of g is high when in state D
	assign g[2] = (state == 3'b011); // Bit 2 of g is high when in state C
	assign g[1] = (state == 3'b010); // Bit 1 of g is high when in state B
	assign g[0] = 1'b0; // All other bits of g are low

endmodule
