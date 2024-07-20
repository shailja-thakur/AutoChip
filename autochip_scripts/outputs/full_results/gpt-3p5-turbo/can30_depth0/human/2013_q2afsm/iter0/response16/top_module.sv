module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state, next_state;

	parameter A = 3'b001;
	parameter B = 3'b010;
	parameter C = 3'b011;
	parameter D = 3'b100;

	always @(posedge clk, negedge resetn) begin
		if (~resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(state, r) begin
		case (state)
			A: begin
				if (r[1] && ~r[2] && ~r[3])
					next_state = B;
				else if (~r[1] && r[2] && ~r[3])
					next_state = C;
				else if (~r[1] && ~r[2] && ~r[3])
					next_state = D;
				else
					next_state = A;
			end
			B: begin
				if (r[1])
					next_state = B;
				else
					next_state = A;
			end
			C: begin
				if (r[2])
					next_state = C;
				else
					next_state = A;
			end
			D: begin
				next_state = A;
			end
			default: begin
				next_state = A;
			end
		endcase
	end

	always @(state) begin
		case (state)
			A: begin
				g[1] = (r[1] && ~r[2] && ~r[3]);
				g[2] = (r[2]);
				g[3] = (r[3]);
			end
			B: begin
				g[1] = (r[1]);
				g[2] = (r[2]);
				g[3] = (r[3]);
			end
			C: begin
				g[1] = (r[1]);
				g[2] = (r[2] && ~r[1]);
				g[3] = (r[3]);
			end
			D: begin
				g[1] = (r[1]);
				g[2] = (r[2]);
				g[3] = (r[3]);
			end
			default: begin
				g[1] = 0;
				g[2] = 0;
				g[3] = 0;
			end
		endcase
	end
endmodule
