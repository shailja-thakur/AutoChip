module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output reg tc
);

	reg [9:0] counter;

	always @(posedge clk) begin
		if (load) begin
			counter <= data;
		end else begin
			if (counter != 10'd0)
				counter <= counter - 1;
		end
		tc <= (counter == 10'd0);
	end
endmodule
