module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State declaration
	typedef enum logic [2:0] {
		A = 3'd0,
		B = 3'd1,
		C = 3'd2,
		D = 3'd3,
		E = 3'd4,
		F = 3'd5
	} state_t;
	
	state_t state, next_state;
	
	// State register
	always_ff @(posedge clk or posedge reset) begin
		if (reset) 
			state <= A;
		else
			state <= next_state;
	end
	
	// Next state and output logic
	always_comb begin
		case (state)
			A: begin
				next_state = w ? A : B;
				z = 1'b0;
			end
			B: begin
				next_state = w ? D : C;
				z = 1'b0;
			end
			C: begin
				next_state = w ? D : E;
				z = 1'b0;
			end
			D: begin
				next_state = w ? A : F;
				z = 1'b0;
			end
			E: begin
				next_state = w ? D : E;
				z = 1'b1;
			end
			F: begin
				next_state = w ? D : C;
				z = 1'b1;
			end
			default: begin
				next_state = A;
				z = 1'b0;
			end
		endcase
	end
endmodule
