module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [3:0] state, next_state;

parameter A = 0, B = 1, S0 = 2, S1 = 3, S10 = 4, G1 = 5, G2 = 6, P0 = 7, P1 = 8;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case (state)
		A: begin
			next_state = B;
		end
		B: begin
			next_state = S0;
		end
		S0: begin
			if (x) begin
				next_state = S1;
			end else begin
				next_state = S0;
			end
		end
		S1: begin
			if (x) begin
				next_state = S1;
			end else begin
				next_state = S10;
			end
		end
		S10: begin
			if (x) begin
				next_state = G1;
			end else begin
				next_state = S0;
			end
		end
		G1, G2: begin
			if (y) begin
				next_state = P1;
			end else begin
				next_state = G2;
			end
		end
		P0, P1: begin
			next_state = state;
		end
		default: begin
			next_state = A;
		end
	endcase
end

assign f = (state == B);
assign g = (state == G1 || state == G2 || state == P1);

endmodule
