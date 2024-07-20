module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// state register
	reg state;

	// output register
	reg out;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 1'b1; // reset state B
		end else begin
			case (state)
				1'b0: begin
					if (in) begin
						state <= 1'b0; // stay in state A
					end else begin
						state <= 1'b1; // transition to state B
					end
				end
				1'b1: begin
					if (in) begin
						state <= 1'b1; // stay in state B
					end else begin
						state <= 1'b0; // transition to state A
					end
				end
			endcase
		end
	end

	// Output logic
	always @(state) begin
		case (state)
			1'b0: out <= 1'b0; // in state A, output 0
			1'b1: out <= 1'b1; // in state B, output 1
		endcase
	end

endmodule
