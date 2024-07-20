module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	// State declaration
	reg [1:0] state;

	// State assignment
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b10; // Initializing to state B
		else begin
			case (state)
				2'b10: if (in) state <= 2'b10; else state <= 2'b01;
				2'b01: if (in) state <= 2'b01; else state <= 2'b10;
				default: state <= 2'b10; // Default should never occur
			endcase
		end
	end

	// Output assignment
	always @(state) begin
		case (state)
			2'b10: out <= 1'b1;
			default: out <= 1'b0;
		endcase
	end
endmodule
