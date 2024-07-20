module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state;
	reg [3:1] next_state;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 3'b001; // Initialize state to A
		end else begin
			state <= next_state; // Update state based on next_state
		end
	end

	always @(state, r) begin
		case (state)
			3'b001: begin // State A
				if (r[3]) begin // If r[3] is high
					next_state = 3'b100; // Next state is D
				end else if (r[2]) begin // Else if r[2] is high
					next_state = 3'b011; // Next state is C
				end else if (r[1]) begin // Else if r[1] is high
					next_state = 3'b010; // Next state is B
				end else begin // Else if none of the bits are high
					next_state = 3'b001; // Next state is A
				end
			end

			3'b010: begin // State B
				if (r[1]) begin // If r[1] is high
					next_state = 3'b010; // Next state is B
				end else begin // Else if r[1] is low
					next_state = 3'b001; // Next state is A
				end
			end

			3'b011: begin // State C
				if (r[2]) begin // If r[2] is high
					next_state = 3'b011; // Next state is C
				end else begin // Else if r[2] is low
					next_state = 3'b001; // Next state is A
				end
			end

			3'b100: begin // State D
				if (r[3]) begin // If r[3] is high
					next_state = 3'b100; // Next state is D
				end else begin // Else if r[3] is low
					next_state = 3'b001; // Next state is A
				end
			end
		endcase
	end

	always @(state) begin
		case (state)
			3'b010: g = 3'b001; // State B, g[1] is high
			3'b011: g = 3'b010; // State C, g[2] is high
			3'b100: g = 3'b100; // State D, g[3] is high
			default: g = 3'b000; // All other states, all bits of g are low
		endcase
	end

endmodule
