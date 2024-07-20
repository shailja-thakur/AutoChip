module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;

	reg [2:0] state;
	reg [2:0] next_state;

	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= A;
		else
			state <= next_state;
	end

	always @* begin
		case (state)
			A: if (r[1])
					next_state = B;
				else if (r[2])
					next_state = C;
				else if (r[3])
					next_state = D;
				else
					next_state = A;
			B: if (r[1])
					next_state = B;
				else
					next_state = A;
			C: if (r[2])
					next_state = C;
				else
					next_state = A;
			D: if (r[1] || r[2] || r[3])
					next_state = D;
				else
					next_state = A;
			default: next_state = A;
		endcase
	end

	always @* begin
		g[1] = (state == B || (state == A && !(r[2] || r[3])) || state == D);
		g[2] = (state == C || (state == A && !r[3]));
		g[3] = (state == A && !r[1] && !r[2] && !r[3]);
	end

endmodule
