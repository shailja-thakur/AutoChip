module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	// State encoding
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;
	
	state_t state, next_state;

	// State flip-flops (with synchronous reset)
	always @(posedge clk) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	// State transition and output logic
	always @(*) begin
		// Default outputs
		g = 3'b000;
		next_state = state;

		case (state)
			A: begin
				if (r[1]) begin
					next_state = B;
				end else if (r[2]) begin
					next_state = C;
				end else if (r[3]) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
			B: begin
				g[1] = 1;
				if (r[1]) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			C: begin
				g[2] = 1;
				if (r[2]) begin
					next_state = C;
				end else begin
					next_state = A;
				end
			end
			D: begin
				g[3] = 1; // Grants for state D if needed, though it was not clearly stated in the problem
				next_state = A; // Return to A after granting device 3
			end
			default: next_state = A;
		endcase
	 end

endmodule
