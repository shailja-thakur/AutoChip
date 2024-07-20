module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

// Internal register to store the count value
reg [9:0] count;

// Always block triggered on the positive edge of the clock
always @(posedge clk) begin
	// Check if the reset input is active
	if (reset) begin
		// Reset the count to 0
		count <= 0;
	end else begin
		// Increment the count by 1
		count <= count + 1;
	end
	
	// Check if the count reaches 999
	if (count == 999) begin
		// Reset the count to 0
		count <= 0;
	end
end

// Assign the value of the count register to the output register
assign q = count;

endmodule
