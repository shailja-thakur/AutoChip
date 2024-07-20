module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	parameter A = 1'b0, B = 1'b1;
	
	// State register
	reg state, next_state;
	
	// State transition logic (combinational)
	always @(*) begin
		case (state)
			A: begin
				if (x == 1'b1)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				next_state = B;
			end
		endcase
	end
	
	// State flip-flops with asynchronous reset (sequential)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Output logic (combinational)
	always @(*) begin
		case (state)
			A: z = (x == 1'b1) ? 1'b1 : 1'b0;
			B: z = (x == 1'b0) ? 1'b1 : 1'b0;
			default: z = 1'b0;
		endcase
	end

endmodule
