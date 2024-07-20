module top_module(
    input clk,
    input reset,
    output shift_ena);
	
	// Internal Signals
	reg [3:0] count;
	reg shift_ena;

	// Register for counting clock cycles
	always @(posedge clk or posedge reset) begin
		if (reset)
			count <= 4'b0000;
		else if (count == 4'b0011)
			count <= 4'b0000;
		else
			count <= count + 1;
	end

	// Output signal generation
	always @(posedge clk or posedge reset) begin
		if (reset)
			shift_ena <= 1'b1;
		else if (count == 4'b0000)
			shift_ena <= 1'b0;
	end

endmodule
