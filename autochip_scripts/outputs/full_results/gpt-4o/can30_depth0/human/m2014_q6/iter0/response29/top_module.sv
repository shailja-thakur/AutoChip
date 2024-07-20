module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State encoding
	reg [2:0] state, next_state;
	parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

	// State transition
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state and output logic
	always @ (*) begin
		case (state)
			A: begin
				if (w) next_state = A;
				else next_state = B;
				z = 0;
			end
			B: begin
				if (w) next_state = D;
				else next_state = C;
				z = 0;
			end
			C: begin
				if (w) next_state = D;
				else next_state = E;
				z = 0;
			end
			D: begin
				if (w) next_state = A;
				else next_state = F;
				z = 0;
			end
			E: begin
				if (w) next_state = D;
				else next_state = E;
				z = 1;
			end
			F: begin
				if (w) next_state = D;
				else next_state = C;
				z = 1;
			end
			default: begin
				next_state = A;
				z = 0;
			end
		endcase
	end
endmodule
