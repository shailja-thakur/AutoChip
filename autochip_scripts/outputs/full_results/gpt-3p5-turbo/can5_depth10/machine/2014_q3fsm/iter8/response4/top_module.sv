module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

	reg [2:0] state, next_state;

	// State definitions
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter S10 = 3'b011;
	parameter S11 = 3'b100;
	parameter S20 = 3'b101;
	parameter S21 = 3'b110;
	parameter S22 = 3'b111;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	always @* begin
		case (state)
			A: if (s) next_state = B;
			   else next_state = A;
			B: if (w) next_state = S11;
			   else next_state = S10;
			C: if (w) next_state = S11;
			   else next_state = S10;
			S10: if (w) next_state = S21;
			     else next_state = S20;
			S11: if (w) next_state = S22;
			     else next_state = S21;
			S20: next_state = B;
			S21: if (w) next_state = C;
			     else next_state = B;
			S22: if (w) next_state = B;
			     else next_state = C;
		endcase
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			z <= 0;
		end
		else begin
			case (state)
				A, B, C, S10, S11, S20, S21, S22: z <= 1;
			endcase
		end
	end

endmodule
