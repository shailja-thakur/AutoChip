module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	always @(posedge clk) begin
		if(a == 1'b1)
			q <= 3'b100; // q will be set to 4
		else if(a == 1'b0 && q == 3'b110)
			q <= 3'b000; // q will be set to 0
		else if(a == 1'b0 && q != 3'b110)
			q <= q + 1; // q will be incremented by 1
	end
endmodule
