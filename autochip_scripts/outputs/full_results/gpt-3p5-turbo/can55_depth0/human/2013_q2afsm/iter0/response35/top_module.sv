module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	reg [1:0] state, next_state;
	wire g1, g2, g3;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	always @(state or r) begin
		g[1] = 0;
		g[2] = 0;
		g[3] = 0;
		case(state)
			A: begin
				if (r[1] && !r[2] && !r[3])
					next_state = A;
				else if (r[1] && !r[2] && !r[3])
					next_state = B;
				else if (!r[1] && r[2] && !r[3])
					next_state = C;
				else if (!r[1] && !r[2] && !r[3])
					next_state = D;
			end
			B: begin
				if (g1 && r[1])
					next_state = B;
				else if (g1 && !r[1])
					next_state = A;
			end
			C: begin
				if (g2 && r[2])
					next_state = C;
				else if (g2 && !r[2])
					next_state = A;
			end
		endcase
	end

	assign g[1] = (state == B);
	assign g[2] = (state == C);
	assign g[3] = ((state == A) && !r[1] && !r[2] && r[3]);

endmodule
