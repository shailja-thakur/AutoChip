module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// define states
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	parameter E = 4;
	parameter F = 5;
	
	// define reg variables for state and next_state
	reg [2:0] state;
	reg [2:0] next_state;

	// define reg variable for output
	reg z;
	
	// always block to compute next state and assign output
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
			z <= 0;
		end else begin
			state <= next_state;
			z <= (state == F || state == E) ? 1 : 0;
		end
	end
	
	// combinational logic to compute next_state
	always @(*) begin
		case (state)
			A: if (w) next_state = A; else next_state = B;
			B: if (w) next_state = D; else next_state = C;
			C: if (w) next_state = D; else next_state = E;
			D: if (w) next_state = A; else next_state = F;
			E: if (w) next_state = D; else next_state = E;
			F: if (w) next_state = D; else next_state = C;
			default: next_state = A;
		endcase
	end
	
endmodule
