module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b10;
		out <= 1'b1;
	end else begin
		case (state)
			2'b00: begin	// State B
				if (in) begin
					state <= 2'b01;	// Transition to state A
					out <= 1'b0;	// Set output to 0
				end
			end
			2'b01: begin	// State A
				if (in) begin
					state <= 2'b01;	// Stay in state A
				end else begin
					state <= 2'b00;	// Transition to state B
				end
			end
			default: state <= 2'b10;	// Reset to state B
		endcase
	end
end
	
endmodule
