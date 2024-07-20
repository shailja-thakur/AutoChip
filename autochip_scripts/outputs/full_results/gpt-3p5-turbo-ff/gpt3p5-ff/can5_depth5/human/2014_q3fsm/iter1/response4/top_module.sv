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
	reg w_buf;
	
	// Assign initial values
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;  // Reset state A
		else if (state == 2'b00 && s)
			state <= 2'b01;  // Move to state B
		else
			state <= state;
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
			w_buf <= w;  // Buffer the input w in state A
	end
	
	always @(posedge clk) begin
		if (state == 2'b01) begin
			count <= count + 1;  // Increment count in state B
			
			if (count == 2 && w_buf == 1) begin
				z <= 1;  // Set output z to 1 if two 1's occurred in the last three cycles
				count <= 0;  // Reset count
			end else if (count == 3) begin
				z <= 0;  // Set output z to 0 if no two 1's occurred in the last three cycles
				count <= 0;  // Reset count
			end
		end
	end
	
endmodule
