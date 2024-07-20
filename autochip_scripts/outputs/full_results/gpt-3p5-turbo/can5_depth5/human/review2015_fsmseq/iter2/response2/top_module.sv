module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);


	// Declare internal signals
	reg [3:0] state;
	reg start_shifting_reg;

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 4'b0000;
		else if (data && (state == 4'b0011))
			state <= 4'b0100;
		else if (data)
			state <= state + 1;
		else
			state <= 4'b0000;
	end
	
	// Sequential logic for start_shifting output
	always @(posedge clk or posedge reset) begin
		if (reset)
			start_shifting_reg <= 0;
		else if (state == 4'b0100)
			start_shifting_reg <= 1;
		else
			start_shifting_reg <= 0;
	end

	// Assign start_shifting output
	assign start_shifting = start_shifting_reg;
	
endmodule
