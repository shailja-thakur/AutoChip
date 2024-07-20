module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state;
	reg [3:1] next_state;

	always @(posedge clk) begin
		if (!resetn)
			state <= 3'b001; // Set state to A when resetn is low
		else
			state <= next_state; // Update state based on next_state when resetn is high
	end

	always @(state, r) begin
		case (state)
			3'b001: begin // State A
				if (r[3])
					next_state = 3'b100; // Next state is D if r[3] is high
				else if (r[2])
					next_state = 3'b011; // Next state is C if r[2] is high
				else if (r[1])
					next_state = 3'b010; // Next state is B if r[1] is high
				else
					next_state = 3'b001; // Next state is A
			end
			3'b010: begin // State B
				if (r[1])
					next_state = 3'b010; // Next state is B if r[1] is high
				else
					next_state = 3'b001; // Next state is A
			end
			3'b011: begin // State C
				if (r[2])
					next_state = 3'b011; // Next state is C if r[2] is high
				else
					next_state = 3'b001; // Next state is A
			end
			3'b100: begin // State D
				if (r[3])
					next_state = 3'b100; // Next state is D if r[3] is high
				else
					next_state = 3'b001; // Next state is A
			end
		endcase
	end

	always @(state) begin
		case (state)
			3'b010: g[1] = 1'b1; // Set g[1] to high when state is B
			3'b011: g[2] = 1'b1; // Set g[2] to high when state is C
			3'b100: g[3] = 1'b1; // Set g[3] to high when state is D
			default: g = 3'b000; // Set all bits of g to low for other states
		endcase
	end
endmodule
