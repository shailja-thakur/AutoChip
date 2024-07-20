module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [3:0] state, next_state;

	parameter A = 4'b0000;
	parameter B = 4'b0001;
	parameter S0 = 4'b0010;
	parameter S1 = 4'b0011;
	parameter S10 = 4'b0100;
	parameter G1 = 4'b0101;
	parameter G2 = 4'b0110;
	parameter P0 = 4'b0111;
	parameter P1 = 4'b1000;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	always @(*) begin
		case(state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = S0;
			end
			B: next_state = S0;
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S10;
			end
			S10: begin
				if (x)
					next_state = G1;
				else
					next_state = S0;
			end
			G1: begin
				if (y)
					next_state = P1;
				else
					next_state = G2;
			end
			G2: begin
				if (y)
					next_state = P1;
				else
					next_state = P0;
			end
			P0: next_state = P0;
			P1: next_state = P1;
		endcase
	end

	assign f = (state == B) ? 1'b1 : 1'b0;
	assign g = (state == G1 || state == G2 || state == P1) ? 1'b1 : 1'b0;

endmodule
