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
		end else if (counter > 0) begin
			counter <= counter - 1;
		end

		// Set the terminal count signal
		if (counter == 0) begin
			tc <= 1;
		end else begin
			tc <= 0;
		end
	end

endmodule
