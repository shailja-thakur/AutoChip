module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	// Define the logic equations for the states transitions and outputs
	always @(*) begin
		case(state)
			10'b00_000_0001: next_state = 10'b01_000_0000;
			10'b00_000_0010: next_state = 10'b10_000_0000;
			10'b00_000_0011: next_state = 10'b00_000_1000;
			10'b00_000_0100: next_state = 10'b01_000_0000;
			10'b00_000_0101: next_state = 10'b01_000_0000;
			10'b00_000_0110: next_state = 10'b01_000_0000;
			10'b00_000_1011: next_state = 10'b01_000_0000;
			10'b00_000_1100: next_state = 10'b01_000_0000;
			10'b00_000_1101: next_state = 10'b01_000_0000;
			10'b00_000_1110: next_state = 10'b01_000_0000;
			default: next_state = 10'b00_000_0000;
		endcase
	end
	
	assign out1 = state[6] | state[9];
	assign out2 = state[7];
	
endmodule
