module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	reg [1:0] state, next_state;
	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	assign f = (state == B);
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end
	always @(state, x, y) begin
		next_state = state;
		case (state)
			A: begin
				if (resetn)
					next_state = B;
			end
			B: begin
				if (resetn)
					next_state = (x == 1) ? C : B;
			end
			C: begin
				if (resetn)
					next_state = (x == 0) ? D : C;
			end
			D: begin
				if (resetn)
					next_state = (x == 1) ? B : (y == 1) ? C : A;
			end
			default: next_state = A;
		endcase
	end
	assign g = (state == C || state == D);
endmodule
