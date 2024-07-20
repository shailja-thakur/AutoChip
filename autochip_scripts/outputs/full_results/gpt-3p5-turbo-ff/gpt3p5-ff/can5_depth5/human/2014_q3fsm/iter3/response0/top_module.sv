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
	reg is_resetting;
	
	// Assign initial values
	always @(posedge clk or posedge reset) begin
		if (reset)
			begin
				state <= 2'b00;  // Reset state A
				is_resetting <= 1;
			end
		else if (state == 2'b00 && s)
			state <= 2'b01;  // Move to state B
		else
			state <= state;
		
		is_resetting <= 0;
	end
	
	always @(posedge clk) begin
		count <= (state == 2'b01 && !is_resetting) ? count + 1 : 0;  // Increment count in state B
		
		if (count == 3) begin
			if (count[2] + count[0] == 2 && prev_w == 1)  // Check if exactly two 1's occurred in the last three cycles
				z <= 1;  // Set output z to 1
			else
				z <= 0;  // Set output z to 0
			
			count <= 0;  // Reset count
		end
		
		prev_w <= w;
	end
	
endmodule
