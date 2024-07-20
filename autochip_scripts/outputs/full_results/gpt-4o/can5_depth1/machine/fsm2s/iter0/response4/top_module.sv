module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	localparam A = 1'b0;
	localparam B = 1'b1;

	reg state, next_state;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A; // Initial state
		end
		else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (j)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (k)
					next_state = A;
				else
					next_state = B;
			end
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out <= 1'b0; // Output for state A
		end
		else begin
			case (state)
				A: out <= 1'b0;
				B: out <= 1'b1;
				default: out <= 1'b0;
			endcase
		end
	end

endmodule
