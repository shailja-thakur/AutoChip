module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	// State declaration
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;

	// Internal signals (current state, next state)
	reg [2:0] current_state;
	reg [2:0] next_state;

	// Initialization
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			current_state <= A;
			g <= 3'b000;
		end else begin
			current_state <= next_state;
		end
	end

	// State updates and next state logic
	always @(*) begin
		// Default values for next state and outputs
		next_state = current_state;
		g <= 3'b000;

		// State transitions
		case (current_state)
			A: begin
				if (r[1]) begin
					next_state = B;
				end else if (r[2]) begin
					next_state = C;
				end else if (r[3]) begin
					next_state = D;
				end
			end
			B: begin
				if (r[1]) begin
					next_state = B;
					g[1] = 1;
				end else begin
					next_state = A;
				end
			end
			C: begin
				if (r[2]) begin
					next_state = C;
					g[2] = 1;
				end else begin
					next_state = A;
				end
			end
			D: begin
				if (r[1] || r[2] || r[3]) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
		endcase
	end
endmodule
