module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [3:0] ones, tens, hundreds, thousands;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else begin
			if (ena[1])
				ones <= ones + 1;
			if (ena[2])
				tens <= tens + 1;
			if (ena[3])
				hundreds <= hundreds + 1;
			
			// Increment thousands digit every 10,000 clock cycles
			if ((q[15:0] + 1) % 10000 == 0)
				thousands <= thousands + 1;
			
            // Combine all digits into q
			q[3:0] = ones;
			q[7:4] = tens;
			q[11:8] = hundreds;
			q[15:12] = thousands;
		end
	end
endmodule
