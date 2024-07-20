module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	reg [9:0] next_state_reg;
	always @(*) begin
		case(state)
			10'b1_0000_0000: next_state_reg = 10'b1_0000_0000; // S0 (0, 0) --0--> S0
			10'b1_0000_0000: next_state_reg = in ? 10'b1_0000_0001 : 10'b1_0000_0000; // S0 (0, 0) --1--> S1
			10'b1_0000_0001: next_state_reg = in ? 10'b1_0000_0010 : 10'b1_0000_0000; // S1 (0, 0) --0--> S0
			10'b1_0000_0001: next_state_reg = in ? 10'b1_0000_0011 : 10'b1_0000_0000; // S1 (0, 0) --1--> S2
			10'b1_0000_0010: next_state_reg = in ? 10'b1_0000_0010 : 10'b1_0000_0000; // S2 (0, 0) --0--> S0
			10'b1_0000_0010: next_state_reg = in ? 10'b1_0000_0011 : 10'b1_0000_0000; // S2 (0, 0) --1--> S3
			10'b1_0000_0011: next_state_reg = in ? 10'b1_0000_0010 : 10'b1_0000_0000; // S3 (0, 0) --0--> S0
			10'b1_0000_0011: next_state_reg = in ? 10'b1_0000_0100 : 10'b1_0000_0000; // S3 (0, 0) --1--> S4
			10'b1_0000_0100: next_state_reg = in ? 10'b1_0000_0010 : 10'b1_0000_0000; // S4 (0, 0) --0--> S0
			10'b1_0000_0100: next_state_reg = in ? 10'b1_0000_0101 : 10'b1_0000_0000; // S4 (0, 0) --1--> S5
			10'b1_0000_0101: next_state_reg = in ? 10'b1_0000_1000 : 10'b1_0000_0000; // S5 (0, 0) --0--> S8
			10'b1_0000_0101: next_state_reg = in ? 10'b1_0000_0110 : 10'b1_0000_0000; // S5 (0, 0) --1--> S6
			10'b1_0000_0110: next_state_reg = in ? 10'b1_0000_1001 : 10'b1_0000_0000; // S6 (0, 0) --0--> S9
			10'b1_0000_0110: next_state_reg = in ? 10'b1_0000_0111 : 10'b1_0000_0000; // S6 (0, 0) --1--> S7
			10'b1_0000_0111: next_state_reg = in ? 10'b1_0000_0000 : 10'b1_0000_0000; // S7 (0, 1) --0--> S0
			10'b1_0000_0111: next_state_reg = in ? 10'b1_0000_0111 : 10'b1_0000_0000; // S7 (0, 1) --1--> S7
			10'b1_0000_1000: next_state_reg = in ? 10'b1_0000_0000 : 10'b1_0000_0000; // S8 (1, 0) --0--> S0
			10'b1_0000_1000: next_state_reg = in ? 10'b1_0000_0001 : 10'b1_0000_0000; // S8 (1, 0) --1--> S1
			10'b1_0000_1001: next_state_reg = in ? 10'b1_0000_0000 : 10'b1_0000_0000; // S9 (1, 1) --0--> S0
			10'b1_0000_1001: next_state_reg = in ? 10'b1_0000_0001 : 10'b1_0000_0000; // S9 (1, 1) --1--> S1
			default: next_state_reg = 10'b0_0000_0000; // Default state if current state is not recognized
		endcase
	end

	assign next_state = next_state_reg;
	assign out1 = (state == 10'b1_0000_0111) ? 1'b0 : 1'b0; // Output out1 is always zero except when in state S7 (0, 1)
	assign out2 = (state == 10'b1_0000_0101) ? 1'b1 : 1'b0; // Output out2 is one only in state S5 (0, 0)

endmodule
