module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

	// State codes
	parameter A = 3'd0;
	parameter B = 3'd1;
	parameter C = 3'd2;
	parameter D = 3'd3;

	// Registers for the state flip-flops
	reg [2:0] state_reg;
	reg [2:0] state_next;

	// Output assignments for g
	assign g[2] = (state_reg == A && r[2] == 1'b1) ? 1'b1 : 1'b0;
	assign g[1] = (state_reg == A && r[1] == 1'b1) ? 1'b1 :
				(state_reg == B && r[1] == 1'b1) ? 1'b1 :
				(state_reg == C && r[1] == 1'b1) ? 1'b1 : 1'b0;
	assign g[0] = (state_reg == A && r[0] == 1'b1) ? 1'b1 :
				(state_reg == C && r[0] == 1'b1) ? 1'b1 : 1'b0;

	// State flip-flop always block
	always @(posedge clk) begin
		if (resetn == 1'b0) begin
			state_reg <= A;
		end else begin
			state_reg <= state_next;
		end
	end

	// State table always block
	always @* begin
		case (state_reg)
			A: begin
				if (r[0] && !r[1] && !r[2])
					state_next = D;
				else if (!r[0] && r[1] && !r[2])
					state_next = B;
				else if (!r[0] && !r[1] && r[2])
					state_next = C;
				else
					state_next = A;
			end
			B: begin
				if (r[0] && g[0])
					state_next = B;
				else if (!r[0] && !g[0])
					state_next = A;
				else
					state_next = B;
			end
			C: begin
				if (r[1] && g[1])
					state_next = C;
				else if (!r[1] && !g[1])
					state_next = A;
				else
					state_next = C;
			end
			D: begin
				state_next = A;
			end
			default: begin
				state_next = A;
			end
		endcase
	end

endmodule
