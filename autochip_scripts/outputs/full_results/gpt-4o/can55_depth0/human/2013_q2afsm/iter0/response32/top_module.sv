module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	// State encoding
	typedef enum reg [1:0] {
		S_A = 2'b00,
		S_B = 2'b01,
		S_C = 2'b10,
		S_D = 2'b11
	} state_t;

	// State variables
	state_t state, next_state;

	// State flip-flops
	always @(posedge clk) begin
		if (!resetn)
			state <= S_A; // Reset state
		else
			state <= next_state;
		end

	// Next state logic
	always @(*) begin
		case (state)
			S_A: begin
				if (r[1])
					next_state = S_B;
				else if (r[2])
					next_state = S_C;
				else if (r[3])
					next_state = S_D;
				else
					next_state = S_A;
			end
			S_B: begin
				if (r[1])
					next_state = S_B;
				else
					next_state = S_A;
			end
			S_C: begin
				if (r[2])
					next_state = S_C;
				else
					next_state = S_A;
			end
			S_D: begin
				if (r[3])
					next_state = S_D;
				else
					next_state = S_A;
			end
			default: next_state = S_A;
		endcase
	end

	// Output logic
	assign g[1] = (state == S_B);
	assign g[2] = (state == S_C);
	assign g[3] = (state == S_D);

endmodule
