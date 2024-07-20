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
	reg prev_w;
	
	// Assign initial values
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;  // Reset state A
		else if (state == 2'b00 && s)
			state <= 2'b01;  // Move to state B
		else if (state == 2'b01 && count == 3)
			state <= 2'b10;  // Move to state C
		else
			state <= state;
	end
	
	always @(posedge clk) begin
		
		if (state == 2'b01)
			count <= count + 1;  // Increment count in state B
		else if (state == 2'b10 && count == 0)
			count <= 1;  // Start counting again in state C
		else if (state == 2'b10)
			count <= count + 1;  // Increment count in state C
		else
			count <= 0;  // Reset count
		
		if (state == 2'b01 && count == 3) begin
			if (prev_w + w == 2)  // Check if exactly two 1's occurred in the last three cycles
				z <= 1;  // Set output z to 1
			else
				z <= 0;  // Set output z to 0
		end
		
		prev_w <= w;
	end
	
endmodule
