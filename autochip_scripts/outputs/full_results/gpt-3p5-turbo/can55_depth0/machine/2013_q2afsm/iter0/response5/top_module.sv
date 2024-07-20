module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output reg [2:0] g
);

	// State register
	reg [1:0] state;

	// Next state register
	reg [1:0] next_state;

	always @(posedge clk) begin
		if (~resetn) begin
			state <= 2'b00; // Set state to A
		end else begin
			state <= next_state; // Set state to the next state
		end
	end

	always @* begin
		case (state)
			2'b00: begin // State A
				if (r[2]) begin
					next_state = 2'b10; // Next state is C
				end else if (r[1]) begin
					next_state = 2'b01; // Next state is B
				end else if (r[0]) begin
					next_state = 2'b11; // Next state is D
				end else begin
					next_state = 2'b00; // Next state is A
				end
			end

			2'b01: begin // State B
				if (r[1]) begin
					next_state = 2'b01; // Next state is B
				end else begin
					next_state = 2'b00; // Next state is A
				end
			end

			2'b10: begin // State C
				if (r[2]) begin
					next_state = 2'b10; // Next state is C
				end else begin
					next_state = 2'b00; // Next state is A
				end
			end

			2'b11: begin // State D
				if (r[0]) begin
					next_state = 2'b11; // Next state is D
				end else begin
					next_state = 2'b00; // Next state is A
				end
			end
		endcase
	end

	always @(state) begin
		case (state)
			2'b01: g[2] = 1'b1; // State B
			2'b10: g[1] = 1'b1; // State C
			2'b11: g[0] = 1'b1; // State D
			default: g = 3'b0; // All other states
		endcase
	end

endmodule
