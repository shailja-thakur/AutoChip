module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	reg [1:0] state;
	always @(posedge clk, posedge reset) begin
		if(reset)
			state <= 2'b00;  // Reset to state A
		else begin
			case(state)
				2'b00: if(in) state <= 2'b01; else state <= 2'b00;  // State A
				2'b01: if(in) state <= 2'b01; else state <= 2'b10;  // State B
				2'b10: if(in) state <= 2'b11; else state <= 2'b00;  // State C
				2'b11: if(in) state <= 2'b01; else state <= 2'b10;  // State D
			endcase
		end
	end

	always @(state) begin
		case(state)
			2'b00: out = 1'b0;  // Output for state A
			2'b01: out = 1'b0;  // Output for state B
			2'b10: out = 1'b0;  // Output for state C
			2'b11: out = 1'b1;  // Output for state D
		endcase
	end
endmodule
