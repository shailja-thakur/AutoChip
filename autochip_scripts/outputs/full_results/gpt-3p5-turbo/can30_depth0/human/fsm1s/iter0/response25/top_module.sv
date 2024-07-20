module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b10; // Reset to state B
		else
			case (state)
				2'b00: state <= (in) ? 2'b01 : 2'b00; // Transition from state B to state A or stay in state B
				2'b01: state <= (in) ? 2'b01 : 2'b00; // Transition from state A to state A or back to state B
				default: state <= 2'b10; // Default state is B
			endcase
	end
	
	always @(state) begin
		case (state)
			2'b00: out = 1'b1; // Output is 1 in state B
			default: out = 1'b0; // Output is 0 in state A
		endcase
	end
endmodule
