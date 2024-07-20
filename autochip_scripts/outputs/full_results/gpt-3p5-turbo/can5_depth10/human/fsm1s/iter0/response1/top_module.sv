module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	parameter B = 1'b1;
	parameter A = 1'b0;

	reg state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	always @* begin
		case(state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
		endcase
	end

	always @(posedge clk) begin
		case(state)
			B: out <= 1'b1;
			A: out <= 1'b0;
		endcase
	end
	
endmodule
