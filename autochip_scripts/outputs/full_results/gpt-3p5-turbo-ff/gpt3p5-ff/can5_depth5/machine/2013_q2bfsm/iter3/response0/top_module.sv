module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// Define states
	enum {A, B, S0, S1, S10, G1, G2, P0, P1} state, next_state;

	// Outputs
	assign f = (state == B) ? 1'b1 : 1'b0;
	assign g = (state == G1 || state == G2 || state == P1) ? 1'b1 : 1'b0;

	// Sequential logic
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Combinational logic
	always_comb begin
		case (state)
			A: begin
				if (x) begin
					next_state = B;
				end else begin
					next_state = S0;
				end
			end
			B: begin
				next_state = S0;
			end
			S0: begin
				next_state = (x) ? S1 : S0;
			end
			S1: begin
				next_state = (x) ? S1 : S10;
			end
			S10: begin
				next_state = (x) ? G1 : S0;
			end
			G1: begin
				next_state = (y) ? P1 : G2;
			end
			G2: begin
				next_state = (y) ? P1 : P0;
			end
			P0, P1: begin
				next_state = state;
			end
		endcase
	end
	
endmodule
