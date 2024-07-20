module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);
	// State encoding
	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

	// State registers
	reg [1:0] state, next_state;

	// State flip-flops (State registers implementation)
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= A; // Reset to state A
		else
			state <= next_state;
		end

	// State transitions (State table implementation)
	always @(*) begin
		case (state)
			A: begin
				if (r[1])
					next_state = B;
				else if (r[2])
					next_state = C;
				else if (r[3])
					next_state = D;
				else
					next_state = A;
			end
			B: begin
				if (~r[1])
					next_state = A;
				else
					next_state = B;
			end
			C: begin
				if (~r[2])
					next_state = A;
				else
					next_state = C;
			end
			D: next_state = A;
			default: next_state = A;
		endcase
	end

	// FSM outputs
	always @(*) begin
		g = 3'b000; // Default value for g
		case (state)
			B: g[1] = 1'b1; // Grant to device 1
			C: g[2] = 1'b1; // Grant to device 2
			D: g[3] = 1'b1; // Grant to device 3
			default: g = 3'b000; // No grants otherwise
		endcase
	end

endmodule
