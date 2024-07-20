module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// define state names for readability
	parameter [2:0] A = 3'b000;
	parameter [2:0] B = 3'b001;
	parameter [2:0] C = 3'b010;
	parameter [2:0] D = 3'b011;
	parameter [2:0] E = 3'b100;
	parameter [2:0] F = 3'b101;

	reg [2:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	always @* begin
		case (state)
			A: begin
				if (w)
					next_state = A;
				else
					next_state = B;
			end

			B: begin
				if (w)
					next_state = D;
				else
					next_state = C;
			end

			C: begin
				if (w)
					next_state = D;
				else
					next_state = E;
			end

			D: begin
				if (w)
					next_state = A;
				else
					next_state = F;
			end

			E: begin
				if (w)
					next_state = D;
				else
					next_state = E;
			end

			F: begin
				if (w)
					next_state = D;
				else
					next_state = C;
			end
		endcase
	end

	always @(posedge clk) begin
		case (state)
			A, B, C, D, E: z <= 0;
			F: z <= 1;
		endcase
	end

endmodule
