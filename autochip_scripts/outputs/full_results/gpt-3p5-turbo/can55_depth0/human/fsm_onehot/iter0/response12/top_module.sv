module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);
	
	// Output wires for each state
	wire [9:0] next_state_wire;
	wire out1_wire;
	wire out2_wire;
	
	// Assign outputs to wires
	assign next_state = next_state_wire;
	assign out1 = out1_wire;
	assign out2 = out2_wire;
	
	// State transition logic
	always @*
	begin
		case (state)
			10'b0000000001: next_state_wire = 10'b0000000001;
			10'b0000000010: next_state_wire = (in) ? 10'b0000000100 : 10'b0000000010;
			10'b0000000100: next_state_wire = (in) ? 10'b0000001000 : 10'b0000000010;
			10'b0000001000: next_state_wire = (in) ? 10'b0000000010 : 10'b0000001000;
			10'b0000010000: next_state_wire = (in) ? 10'b0000000100 : 10'b0000000010;
			10'b0000001000: next_state_wire = (in) ? 10'b0000000010 : 10'b0000010000;
			10'b0000010000: next_state_wire = (in) ? 10'b0000001000 : 10'b0000010000;
			10'b0000100000: next_state_wire = (in) ? 10'b0000000100 : 10'b0000000010;
			10'b0000010000: next_state_wire = (in) ? 10'b0000000010 : 10'b0000100000;
			10'b0001000000: next_state_wire = (in) ? 10'b0000100000 : 10'b0000010000;
			10'b0010000000: next_state_wire = (in) ? 10'b0000001000 : 10'b0000000100;
			10'b0100000000: next_state_wire = (in) ? 10'b0000000100 : 10'b0001000000;
			10'b1000000000: next_state_wire = (in) ? 10'b0000000010 : 10'b0000000100;
			default: next_state_wire = 10'b0000000001;
		endcase
	end
	
	// Output logic
	assign out1_wire = (state[7] || state[9]);
	assign out2_wire = (state[8]);
	
endmodule
