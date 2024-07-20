module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
    
	// Internal wires and registers
	reg [3:0] counter;
	reg reset_trigger;

	// Synchronous reset logic
	always @(posedge clk) begin
		if (reset) begin
			counter <= 4'b0001;
			reset_trigger <= 1'b1;
		end
		else if (reset_trigger) begin
			counter <= 4'b0000;
			reset_trigger <= 1'b0;
		end
		else begin
			if (counter == 4'b1010)
				counter <= 4'b0001;
			else
				counter <= counter + 1;
		end
	end
	
	// Output assignment
	assign q = counter;
    
endmodule
