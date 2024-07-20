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
	reg s_prev;
	
	// Assign initial values
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;  // Reset state A
		else if (state == 2'b00 && s)
			state <= 2'b01;  // Move to state B
		else
			state <= state;
		
		s_prev <= s;
	end
	
	always @(posedge clk) begin
		count <= (state == 2'b01) ? count + 1 : 0;  // Increment count in state B
		
		if (count == 3) begin
			if (count[2] + count[0] == 2)  // Check if exactly two 1's occurred in the last three cycles
				z <= 1;  // Set output z to 1
			else
				z <= 0;  // Set output z to 0
			
			count <= 0;  // Reset count
		end
	end
	
	always @(posedge clk) begin
		if (state == 2'b00)
			count <= 0;  // Reset count when in state A
		
		if (state == 2'b01 && count == 0 && w == 1 && s_prev == 1)
			count <= 1;
		else if (state == 2'b01 && count == 1 && w == 1 && s_prev == 1)
			count <= 2;
		else if (state == 2'b01 && count == 2 && w == 0 && s_prev == 1)
			count <= 3;
		else if (state == 2'b01 && count == 3 && s_prev == 1) begin
			count <= 0;
			state <= 2'b00;
		end
	end
	
endmodule
