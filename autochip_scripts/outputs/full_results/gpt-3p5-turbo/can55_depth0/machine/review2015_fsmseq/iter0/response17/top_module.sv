module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Register to store the current state of the state machine
	reg [2:0] state;
	
	// Combinational logic block to determine the next state
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			state <= 3'b000; // Initial state S
		else
		begin
			case(state)
				3'b000: // State S
					if (data)
						state <= 3'b001; // Next state S1
					else
						state <= 3'b000; // Next state S
				3'b001: // State S1
					if (data)
						state <= 3'b010; // Next state S11
					else
						state <= 3'b000; // Next state S
				3'b010: // State S11
					if (data)
						state <= 3'b010; // Next state S11
					else
						state <= 3'b011; // Next state S110
				3'b011: // State S110
					if (data)
						state <= 3'b100; // Next state Done
					else
						state <= 3'b000; // Next state S
				3'b100: // State Done
					state <= 3'b100; // Next state Done
			endcase
		end
	end
	
	// Assign the output based on the current state of the state machine
	assign start_shifting = (state == 3'b100) ? 1'b1 : 1'b0;
	
endmodule
