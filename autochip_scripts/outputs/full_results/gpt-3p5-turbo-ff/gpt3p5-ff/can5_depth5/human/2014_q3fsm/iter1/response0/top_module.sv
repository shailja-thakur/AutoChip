module top_module (
	input clk,
    input reset,
    input s,
    input w,
    output reg z
);
	
	// Declare state signals
	reg [1:0] state;
	reg [2:0] count;
	
	// Assign initial values
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;  // Reset state A
		else if (state == 2'b00 && s)
			state <= 2'b01;  // Move to state B
		else if (state == 2'b01 && count == 3)
			state <= 2'b00;  // Move back to state A after three clock cycles in state B
		else
			state <= state;
	end
	
	always @(posedge clk) begin
		if (reset)
			count <= 0;  // Reset count
		else if (state == 2'b01 && count < 3)
			count <= count + 1;  // Increment count in state B
		
		if (count == 3) begin
			if (count[2] + count[0] == 2 && s)  // Check if exactly two 1's occurred in the last three cycles and s is high
				z <= 1;  // Set output z to 1
			else
				z <= 0;  // Set output z to 0
		end
	end
endmodule
