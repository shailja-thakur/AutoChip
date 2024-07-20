module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State encoding
	localparam A = 3'b000,
			   B = 3'b001,
			   C = 3'b010,
			   D = 3'b011,
			   E = 3'b100,
			   F = 3'b101;
	
	// State register
	reg [2:0] state, next_state;

	// State transition table (next state logic)
	always @(*) begin
		case (state)
			A: if (w)
				   next_state = B;
			   else 
				   next_state = A;
			B: if (w)
				   next_state = C;
			   else 
				   next_state = D;
			C: if (w)
				   next_state = E;
			   else 
				   next_state = D;
			D: if (w)
				   next_state = F;
			   else 
				   next_state = A;
			E: if (w)
				   next_state = E;
			   else 
				   next_state = D;
			F: if (w)
				   next_state = C;
			   else 
				   next_state = D;
			default: 
				   next_state = A; // Default to A for any undefined state
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			A, B, C, D: z = 1'b0;
			E, F: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
