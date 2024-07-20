module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output reg tc
);
	reg [9:0] counter;

	always @(posedge clk) begin
		if (load)
			counter <= data;
		else if (counter != 0)
			counter <= counter - 1;
		end
		tc <= (counter == 0);
	end
endmodule
