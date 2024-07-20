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
		end else if (counter != 10'b0) begin
			counter <= counter - 10'b1;
		end
	end
	
	always @(*) begin
		tc = (counter == 10'b0);
	end

endmodule
