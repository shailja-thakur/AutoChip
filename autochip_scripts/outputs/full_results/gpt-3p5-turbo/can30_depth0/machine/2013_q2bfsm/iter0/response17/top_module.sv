module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [1:0] state, next_state;
	parameter A = 2'b00, B = 2'b01, S0 = 2'b10, S1 = 2'b11, S10 = 2'b100, G1 = 2'b101, G2 = 2'b110, P0 = 2'b111, P1 = 2'b1000;

	// FSM state register
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// FSM next state logic
	always @(state or x or y) begin
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
		endcase
	end

	// Outputs
	assign f = (state == B) ? 1'b1 : 1'b0;
	assign g = (state == G1 || state == G2 || state == P1) ? 1'b1 : 1'b0;

endmodule
