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
	reg [2:0] w_count;
	
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
			if (w_count == 2)
				z <= 1;  // Set output z to 1
			else
				z <= 0;  // Set output z to 0
			
			count <= 0;  // Reset count
		end
		
		if (state == 2'b01) begin
			if (w == 1)
				w_count <= w_count + 1;
			else
				w_count <= w_count;
		end else begin
			w_count <= 0;
		end
	end
	
endmodule
