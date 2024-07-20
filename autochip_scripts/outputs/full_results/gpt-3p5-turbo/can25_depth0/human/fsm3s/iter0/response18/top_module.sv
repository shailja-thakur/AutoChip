module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	reg out_reg;
	
	// Assign initial state
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Assign next state and output
	always @*
	begin
		case (state)
			A: if (in) begin next_state = B; out_reg = 0; end else begin next_state = A; out_reg = 0; end
			B: if (in) begin next_state = B; out_reg = 0; end else begin next_state = C; out_reg = 0; end
			C: if (in) begin next_state = D; out_reg = 0; end else begin next_state = A; out_reg = 0; end
			D: if (in) begin next_state = B; out_reg = 1; end else begin next_state = C; out_reg = 0; end
		endcase
	end
	
	// Output register flip-flop
	always @(posedge clk)
	begin
		out <= out_reg;
	end

endmodule
