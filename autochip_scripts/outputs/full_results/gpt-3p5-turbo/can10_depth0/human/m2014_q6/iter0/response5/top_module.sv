module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	parameter E = 4;
	parameter F = 5;
	
	reg [2:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	always @(state or w) begin
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

	always @(state) begin
		case (state)
			A: z = 0;
			B: z = 0;
			C: z = 0;
			D: z = 0;
			E: z = 1;
			F: z = 1;
		endcase
	end

endmodule
