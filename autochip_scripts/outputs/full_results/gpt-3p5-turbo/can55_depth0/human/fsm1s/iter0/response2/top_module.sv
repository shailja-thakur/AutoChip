module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state;
	reg out;
	
	always @(posedge clk) begin
		if (reset)
			state <= 2'b10; // Reset state B
		else if (state == 2'b10) begin
			if (in)
				state <= 2'b10; // Input 1 leads to state B
			else
				state <= 2'b01; // Input 0 leads to state A
		end
		else if (state == 2'b01) begin
			if (in)
				state <= 2'b01; // Input 1 leads to state A
			else
				state <= 2'b10; // Input 0 leads to state B
		end
	end
	
	always @(state) begin
		if (state == 2'b10)
			out <= 1'b1; // Output of state B is 1
		else
			out <= 1'b0; // Output of state A is 0
	end
	
endmodule
