module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	// Output declarations
	wire out1_out;
	wire out2_out;
	
	// State transition logic	
	always @* begin
		case(state)
			10'b0000000001: next_state = 10'b1000000000;  // S0 (0,0)
			10'b0000000010: next_state = (in == 0) ? 10'b1000000000 : 10'b0100000000;  // S1 (0,0)
			10'b0000000100: next_state = (in == 0) ? 10'b1000000000 : 10'b0010000000;  // S2 (0,0)
			10'b0000001000: next_state = (in == 0) ? 10'b1000000000 : 10'b0001000000;  // S3 (0,0)
			10'b0000010000: next_state = (in == 0) ? 10'b1000000000 : 10'b0000100000;  // S4 (0,0)
			10'b0000100000: next_state = (in == 0) ? 10'b0000000100 : 10'b0000010000;  // S5 (0,0)
			10'b0001000000: next_state = (in == 0) ? 10'b0000001000 : 10'b0000001000;  // S6 (0,0)
			10'b0010000000: next_state = (in == 0) ? 10'b1000000000 : 10'b0000000100;  // S7 (0,1)
			10'b0100000000: next_state = (in == 0) ? 10'b1000000000 : 10'b0100000000;  // S8 (1,0)
			10'b1000000000: next_state = (in == 0) ? 10'b1000000000 : 10'b0100000000;  // S9 (1,1)
		endcase
	end
	
	// Output logic
	assign out1 = out1_out;
	assign out2 = out2_out;
	
	always @(state) begin
		case(state)
			10'b0000000011: out1_out = 0; out2_out = 0;  // S0 (0,0)
			10'b0000000100: out1_out = 0; out2_out = 0;  // S1 (0,0)
			10'b0000001000: out1_out = 0; out2_out = 0;  // S2 (0,0)
			10'b0000010000: out1_out = 0; out2_out = 0;  // S3 (0,0)
			10'b0000100000: out1_out = 0; out2_out = 0;  // S4 (0,0)
			10'b0000001000: out1_out = 0; out2_out = 0;  // S5 (0,0)
			10'b0000001000: out1_out = 0; out2_out = 0;  // S6 (0,0)
			10'b0010000000: out1_out = 0; out2_out = 1;  // S7 (0,1)
			10'b0000000100: out1_out = 1; out2_out = 0;  // S8 (1,0)
			10'b1000000000: out1_out = 1; out2_out = 1;  // S9 (1,1)
		endcase
	end	
endmodule
