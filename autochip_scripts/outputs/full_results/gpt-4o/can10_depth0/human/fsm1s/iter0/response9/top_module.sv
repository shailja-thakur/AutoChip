module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	localparam B = 1'b0, A = 1'b1;
	reg state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		case (state)
			B: begin
				if (in == 0)
					next_state = A;
				else
					next_state = B;
			end
			A: begin
				if (in == 0)
					next_state = B;
				else
					next_state = A;
			end
			default: next_state = B; // Default state to handle unexpected cases
		endcase
	end

	// State register (sequential)
	always @(posedge clk) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic (combinational)
	always @(*) begin
		case (state)
			B: out = 1;
			A: out = 0;
		endcase
	end
	
endmodule
