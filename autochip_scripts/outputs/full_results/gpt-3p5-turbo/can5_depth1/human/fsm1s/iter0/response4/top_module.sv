module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state;
	
	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b10; // Reset state B
		else begin
			case (state)
				2'b10: if (in) state <= 2'b10; else state <= 2'b01; // B (out=1) --in=1--> B, B (out=1) --in=0--> A
				2'b01: if (in) state <= 2'b10; else state <= 2'b00; // A (out=0) --in=1--> A, A (out=0) --in=0--> B
				default: state <= 2'b10; // Default case for any other state
			endcase
		end
	end
	
	// Output logic
	always @(state) begin
		case (state)
			2'b10: out = 1; // Output is 1 in state B
			default: out = 0; // Output is 0 in state A
		endcase
	end
	
endmodule
