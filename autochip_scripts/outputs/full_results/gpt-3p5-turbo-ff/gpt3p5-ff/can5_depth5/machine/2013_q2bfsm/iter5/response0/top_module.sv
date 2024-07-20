module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// Define states
	typedef enum logic [3:0] {A, B, S0, S1, S10, G1, G2, P0, P1} states;
	reg states state, next_state;

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
			G1: begin
				if (y) begin
					next_state = P1;
				end else begin
					next_state = G2;
				end
			end
			G2: begin
				if (y) begin
					next_state = P1;
				end else begin
					next_state = P0;
				end
			end
			P0, P1: begin
				next_state = state;
			end
		endcase
	end
	
endmodule
