module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum logic [0:0] {
		A = 1'b0,
		B = 1'b1
	} state_t;
	
	state_t state, next_state;

	// State register
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		case (state)
			B: if (in) next_state = B;
				else next_state = A;
			
			A: if (in) next_state = A;
				else next_state = B;
		endcase
	end

	// Output logic
	always_ff @(posedge clk) begin
		if (reset) begin
			out <= 1'b1; // B state output
		end else begin
			case (state)
				B: out <= 1'b1;
				A: out <= 1'b0;
			endcase
		end
	end

endmodule
