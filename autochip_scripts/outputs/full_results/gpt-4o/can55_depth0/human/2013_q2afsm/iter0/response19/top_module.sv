module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	// State Encoding
	typedef enum logic [1:0] {A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11} state_t;
	state_t state, next_state;
	
	// State Flip-Flops
	always_ff @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end
	
	// State Table
	always_comb begin
		next_state = state; // Default
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
				if (!r[1])
					next_state = A;
				else
					next_state = B;
			end
			C: begin
				if (!r[2])
					next_state = A;
				else
					next_state = C;
			end
			D: begin
				next_state = A;
			end
			default: next_state = A;
		endcase
	end
	
	// FSM Outputs
	always_comb begin
		g = 3'b000; // Default values
		case (state)
			B: g[1] = 1'b1;
			C: g[2] = 1'b1;
			D: g[3] = 1'b1;
			default: g = 3'b000;
		endcase
	end

endmodule
