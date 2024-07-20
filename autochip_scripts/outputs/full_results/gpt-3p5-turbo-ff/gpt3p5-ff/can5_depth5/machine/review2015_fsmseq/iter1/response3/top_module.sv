module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Internal signals
	reg [2:0] state;
	wire [2:0] next_state;
	
	// Assign next state based on current state and data input
	always @(state or data)
	begin
		if (state == 3'b000)
			next_state = (data == 1'b1) ? 3'b001 : 3'b000;
		else if (state == 3'b001)
			next_state = (data == 1'b1) ? 3'b011 : 3'b000;
		else if (state == 3'b011)
			next_state = (data == 1'b1) ? 3'b011 : 3'b110;
		else if (state == 3'b110)
			next_state = (data == 1'b1) ? 3'b111 : 3'b000;
		else
			next_state = 3'b111;
	end
	
	// Register to hold the current state
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 3'b000;
		else
			state <= next_state;
	end
	
	// Output assignment
	assign start_shifting = (state == 3'b111) ? 1'b1 : 1'b0;

endmodule
