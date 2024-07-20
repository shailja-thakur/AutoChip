module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Internal signals
	reg [2:0] state;
	wire [2:0] next_state;
	
	// Assign next state based on current state and data input
	assign next_state = (state == 3'b000 && data) ? 3'b001 :
					   (state == 3'b000 && !data) ? 3'b000 :
					   (state == 3'b001 && data) ? 3'b011 :
					   (state == 3'b001 && !data) ? 3'b000 :
					   (state == 3'b011 && data) ? 3'b011 :
					   (state == 3'b011 && !data) ? 3'b110 :
					   (state == 3'b110 && data) ? 3'b111 :
					   (state == 3'b110 && !data) ? 3'b000 :
					   (state == 3'b111) ? 3'b111 :
					   3'b000;
	
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
